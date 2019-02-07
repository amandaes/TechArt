using System.Collections;
using System.Collections.Generic;
using UnityEngine;
using UnityEditor;

[CustomEditor(typeof(LookAtUnityBezierScript))]
public class LookAtButtonForLAUB : Editor {

    public override void OnInspectorGUI()
    {
        LookAtUnityBezierScript _myLAUB = (LookAtUnityBezierScript)target; //target is variable keyword for editor looks for obj to cast class 

        DrawDefaultInspector();


        if (GUILayout.Button("Test Button"))
        {
            Debug.Log("Button pressed!");

            BezierExample newBe = _myLAUB.myModel.gameObject.AddComponent<BezierExample>();

            if(_myLAUB.curveList.Count > 0)
            {
                BezierExample lastBe = _myLAUB.curveList[_myLAUB.curveList.Count - 1];
                newBe.startPoint = lastBe.endPoint;
                newBe.endPoint = lastBe.endPoint;
                newBe.startTangent = lastBe.endPoint;
                newBe.endTangent = lastBe.endTangent;
               
            }
           

            

            _myLAUB.curveList.Add(newBe);

            
        }
           
       
    }
    
}
