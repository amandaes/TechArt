using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class WalkRunAnimation : MonoBehaviour
{

    private float velX;
    private float velY;

    private float time;

    private float idleTime;

    private Animator myAnim;

    [Header("Tuning")]
    [Range(0.001f, 10.0f)] public float walkCycleTime;
    [Range(0.00f, 1.00f)] public float walkRunMagnitude;

    [Range(0.00f, 1.00f)] public float walkRunBlendTotal;
    // Start is called before the first frame update
    void Start()
    {
        myAnim = GetComponent<Animator>();
    }

    // Update is called once per frame
    void Update()
    {
        if (Input.GetKey(KeyCode.W))
        {
            myAnim.SetBool("IdleFalseMoveTrue", true);
        }
        else
        {
            myAnim.SetBool("IdleFalseMoveTrue", false);
        }

        idleTime += Time.deltaTime * 6;
        myAnim.SetFloat("IdleValX", (Mathf.Sin(idleTime) + 1) / 2);

        walkCycleTime = 1 - (.5f * walkRunBlendTotal);
        walkRunMagnitude = .25f + (.75f * walkRunBlendTotal);

        time += (Mathf.PI * 2 * Time.deltaTime) / walkCycleTime;

        velX = Mathf.Cos(time) * walkRunMagnitude;
        velY = Mathf.Sin(time) * walkRunMagnitude;

        myAnim.SetFloat("VelX", velX);
        myAnim.SetFloat("VelY", velY);
    }
}
