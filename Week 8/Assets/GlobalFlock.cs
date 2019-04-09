using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GlobalFlock : MonoBehaviour
{
    public GameObject agentPrefab;

    static int numAgent = 20;
    public static GameObject[] allAgents = new GameObject[numAgent];

    // Start is called before the first frame update
    void Start()
    {
        for(int i = 0; i< numAgent; i++)
        {

        }   
    }

    // Update is called once per frame
    void Update()
    {
        
    }
}
