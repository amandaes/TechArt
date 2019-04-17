using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class AnimatorParameterController : MonoBehaviour
{

    private float walkRun_TreeVal_X;
    private float walkRun_TreeVal_Y;

    private float time;

    private Animator myAnimator;

    [Header("Tuning Values")]
    [Range(0.001f, 10.0f)] public float walkCycleTime;
    [Range(0.001f, 1.00f)] public float walkRunMagnitude;

    [Range(0.00f, 1.00f)] public float walkRunBlendTotal;

    

    //Soh - opposite/hypotenuse
    //Cah - adjacent/hypotense
    //Toa - opposite/adjacent

    private void Start()
    {
        myAnimator = GetComponent<Animator>();
    }

    void Update()

    {
        if (Input.GetKey(KeyCode.W))
        {
            myAnimator.SetBool("Idle_False_Move_True", true);
        }
        else
        {
            myAnimator.SetBool("Idle_False_Move_True", false);
        }

        idleTime += Time.deltaTime * 6;
        myAnimator.SetFloat("Idle_Blend_X", Mathf.Sin(idleTime)+1)/2);

        walkCycleTime = 1 - (.5f * walkRunBlendTotal);
        walkRunMagnitude = .25f + (.75f * walkRunBlendTotal);

        time += (Mathf.PI*2 * Time.deltaTime)/walkCycleTime; //2PI is the value passed into sin and cos before it makes a whole circle cycle

        //set relationship oh walk blend x & y in time
        //making arch on circle
        walkRun_TreeVal_X = Mathf.Cos(time) * walkRunMagnitude;
        walkRun_TreeVal_Y = Mathf.Sin(time) * walkRunMagnitude;

        myAnimator.SetFloat("Walk_Blend_X", walkRun_TreeVal_X); //the 
        myAnimator.SetFloat("Walk_Blend_Y", walkRun_TreeVal_Y);

    }
}
