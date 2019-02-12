using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class BezierExample : MonoBehaviour {

    public Vector3 startPoint;
    public Vector3 endPoint;
    public Vector3 startTangent;
    public Vector3 endTangent;

    public float linearDist;

    

    public float GetPercForDist(float dist)
    {
        return dist / linearDist;
    }

    public float GetDistForPerc(float perc)
    {
        return perc * linearDist;
    }

    public void RecalculateLinearDist()
    {
        float dist = 0;

        for (float i = 0; i < 1; i += .01f)
        {
            dist += Vector3.Distance(GetPositionOnPath(i), GetPositionOnPath(i + .01f));
        }

        linearDist = dist;
    }

    // Use this for initialization
    void Start () {
		
	}
	
	// Update is called once per frame
	void Update () {
		
	}
}
