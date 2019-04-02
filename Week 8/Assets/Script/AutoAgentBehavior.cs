using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AutoAgentBehavior : MonoBehaviour
{
    public Vector3 moveDirection;
    public float moveVelocityMagnitude;

    public Transform myModelTransform;

    [Range(0.0f, 1.0f)] public float clumpStrength;
    [Range(0.0f, 1.0f)] public float alignStrength;
    [Range(0.0f, 1.0f)] public float avoidanceStrength;
    [Range(0.0f, 1.0f)] public float originStrength;

    void Start()
    {
        
        myModelTransform = transform.GetChild(0);
    }

    
    void Update()
    {
        //transform.position += moveDirection * moveVelocityMagnitude * Time.deltaTime;
        //myModelTransform.rotation = Quaternion.LookRotation(moveDirection);
    }

   
    public void PassArrayOfContext (Collider[] context)
    {
        //use context
        CalcMyDir(context);
        MoveInMyDirection(Vector3.zero, 0);
    }

    void CalcMyDir(Collider[] context)
    {
        //moveDirection = Vector3.Normalize(ClumpDir(context) + Align(context) + Avoidance(context));
        moveDirection = Vector3.Lerp(moveDirection, ClumpDir(context) * clumpStrength + Align(context) * alignStrength + Avoidance(context) * avoidanceStrength + MoveTowardsOrigin()*originStrength * Vector3.Magnitude(transform.position)/15, 0.05f);
    }

    Vector3 ClumpDir (Collider[] context)
    {
        Vector3 midpoint = Vector3.zero;

        foreach (Collider c in context)
        {
            midpoint += c.transform.position;
        }

        midpoint /= context.Length; //getting he mid point from all objects instantiated
        Vector3 dirIWantToGo = midpoint - transform.position; //move to direction
        Vector3 normalizedDirIWantToGo = Vector3.Normalize(dirIWantToGo);
        //moveDirection = normalizedDirIWantToGo;

        return normalizedDirIWantToGo;
    }

    Vector3 Align(Collider[] context)
    {
        Vector3 headings = Vector3.zero;
        foreach(Collider c in context)
        {
            headings += c.transform.GetChild(0).forward;
        }

        headings /= context.Length;

        return Vector3.Normalize(headings);

            
    }

    Vector3 Avoidance(Collider[] context)
    {
        List<Collider> contextWithoutMe = new List<Collider>();
        


        Vector3 midpoint = Vector3.zero;

        foreach (Collider c in context)
        {
            midpoint += c.transform.position;
        }

        midpoint /= context.Length; //getting he mid point from all objects instantiated
        Vector3 dirIWantToGo = midpoint - transform.position; //move to direction
        Vector3 normalizedDirIWantToGo = Vector3.Normalize(dirIWantToGo);

        return (Quaternion.Euler(20, 20, 20)*normalizedDirIWantToGo);
    }

    Vector3 MoveTowardsOrigin()
    {
        return Vector3.zero - transform.position;
    }

    void MoveInMyDirection(Vector3 direction, float magnitude)
    {
        transform.position += direction * magnitude * Time.deltaTime;
        myModelTransform.rotation = Quaternion.LookRotation(direction);
    }
}
