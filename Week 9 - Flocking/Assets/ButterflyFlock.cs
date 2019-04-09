using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class ButterflyFlock : MonoBehaviour
{

    public float speed = 1f;
    float rotationSpeed = 2f;
    Vector3 averageHeading;
    Vector3 averagePosition;
    float neighborDistance = 4f;

    bool turning = false;

    Renderer rend;
    Shader dissolveShader;
    Shader blueShader;

    // Start is called before the first frame update
    void Start()
    {
        speed = Random.Range(5f, 20f);
        rend = GetComponent<Renderer>();
        dissolveShader = Shader.Find("BirdFly");
        blueShader = Shader.Find("BirdShader");
    }

    // Update is called once per frame
    void Update()
    {
        if(Vector3.Distance(transform.position, Vector3.zero) >= GlobalFlock.cageSize)
        {
            turning = true;
        }
        else
        {
           turning = false;
        }

        if (turning)
        {
            Vector3 direction = Vector3.zero - transform.position;
            transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(direction), rotationSpeed * Time.deltaTime);

            speed = Random.Range(5f, 20f);

            if (rend.material.shader == dissolveShader)
            {
                rend.material.shader = blueShader;
            }
            else
            {
                rend.material.shader = dissolveShader;
            }

            
        }
        else
        {
            if (Random.Range(0, 5) < 1)
            {
                ApplyRules();
            }
        }

        transform.Translate(0, 0, Time.deltaTime * speed);
    }

    void ApplyRules()
    {
        //refer to all the butterflies instantiated in globalflock
        GameObject[] gos;
        gos = GlobalFlock.allButterflies;

        Vector3 vCentre = Vector3.zero;
        Vector3 vAvoid = Vector3.zero;
        float gSpeed = 0.1f;

        
        Vector3 goalPos = GlobalFlock.goalPos;

        float dist;
        int groupSize = 0;

        foreach(GameObject go in gos)
        {
            if (go != this.gameObject)
            {
                dist = Vector3.Distance(go.transform.position, this.transform.position);
                if (dist <= neighborDistance) //if dist is within neighbordistance then count them as neighbor
                {
                    vCentre += go.transform.position;
                    groupSize++;
                    
                    if(dist < 1f) //avoid if dist less than 1
                    {
                        vAvoid = vAvoid + (this.transform.position - go.transform.position);
                    }
                }
                ButterflyFlock anotherFlock = go.GetComponent<ButterflyFlock>();
                gSpeed = gSpeed + anotherFlock.speed;
            }
        }

        if (groupSize > 0)
        {
            vCentre = vCentre / groupSize + (goalPos - this.transform.position);
            speed = gSpeed / groupSize;

            Vector3 direction = (vCentre + vAvoid) - transform.position;
            if (direction != Vector3.zero)
            {
                transform.rotation = Quaternion.Slerp(transform.rotation, Quaternion.LookRotation(direction), rotationSpeed * Time.deltaTime);
            }

        }
    }
}
