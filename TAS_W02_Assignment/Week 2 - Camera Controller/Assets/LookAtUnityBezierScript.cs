using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor; //modify things that are specific to tools like buttons

public class LookAtUnityBezierScript : MonoBehaviour {
    //[ExecuteInEditMode] //only use in debug scripts. run script when you are not in play mode.

    public GameObject marker;
    public BezierExample bezEx;
    public Transform myModel;

    public List<BezierExample> curveList = new List<BezierExample>();

   

    //private bool loopClosed;

    public void grabLostCurves()
    {
        curveList.Clear();
        Transform model = GameObject.Find("Model").transform;
        BezierExample[] all = model.GetComponents<BezierExample>();

        for (int i = 0; i < all.Length; i++)
        {
            curveList.Add(all[i]);

        } 
    }

	// Use this for initialization
	public void Start () {
        //Run through 100 points and place a marker at those points on the bezier curver.

        /*
         * Step 1 : For loop throught 100 points between 0 & 1
         * Step 2 : Pass that fraction to a curve calc to find the resultant V3
         * Step 3 : Place a Marker at that V3
         * 
         */

        PutPointsOnCurve();
             
	}

    //marking points on the curve

    private void PutPointsOnCurve()
    {
        for (int i = 0; i <= 100; i++)
        {
            float t = (float)i / 100;
            Vector3 pointOncurve = CalculateBezier(bezEx, t);
            Instantiate(marker, pointOncurve, Quaternion.identity, null);
            CalculateBezier(bezEx, t);
        }
    }
	

    //calculate end point of the last bezier curve and make a new one start at that end point.
    Vector3 CalculateBezier(BezierExample curveData, float t)
    {
        Vector3 a = curveData.startPoint;
        Vector3 b = curveData.startTangent;
        Vector3 c = curveData.endTangent;
        Vector3 d = curveData.endPoint;

        Vector3 ab = Vector3.Lerp(a, b, t);
        Vector3 bc = Vector3.Lerp(b, c, t);
        Vector3 cd = Vector3.Lerp(c, d, t);

        Vector3 abc = Vector3.Lerp(ab, bc, t);
        Vector3 bcd = Vector3.Lerp(bc, cd, t);

        Vector3 final = Vector3.Lerp(abc, bcd, t);

        return final;

    }

    public float camSpeed;
    private float t;
    private int curveIndex;
    private float distToTravel;
    private float percToTravel;
    private Vector3 lastPos;

    public void Update()
    {
        distToTravel = Time.deltaTime * camSpeed;
        percToTravel = curveList[curveIndex].GetPercForDist(distToTravel);

        if (t + percToTravel > 1)
        {
            float PercLeftOnFirstLeg = 1 - t;
            float DistLeftOnFirstLeg = curveList[curveIndex].GetDistForPerc(PercLeftOnFirstLeg);
            float DistCarryover = distToTravel - DistLeftOnFirstLeg;

            curveIndex++;
            if (curveIndex > curveList.Count - 1)
                curveIndex = 0;
            t = curveList[curveIndex].GetPercForDist(DistCarryover);
        }
        else
            t += percToTravel;

        Vector3 spotOnTrack = curveList[curveIndex].GetPositionOnPath(t);
    }


}
