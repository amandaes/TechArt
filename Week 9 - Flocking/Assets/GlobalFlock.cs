using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class GlobalFlock : MonoBehaviour
{

    public GameObject butterflyPrefab;
    static int numButterfly = 50;
    public static GameObject[] allButterflies = new GameObject[numButterfly];
    public static int cageSize = 70;

    public static Vector3 goalPos = Vector3.zero;

    // Start is called before the first frame update
    void Start()
    {
        //create a loop for all the butterflies in array
        for (int i = 0; i < numButterfly; i++)
        {
            //position for fish between value of cageSize
            Vector3 pos = new Vector3(Random.Range(-cageSize, cageSize), Random.Range(-cageSize, cageSize), Random.Range(-cageSize, cageSize));
            //instantiate fish and put in array
            allButterflies[i] = (GameObject)Instantiate(butterflyPrefab, pos, Quaternion.identity);
        }
        
    }

    // Update is called once per frame
    void Update()
    {
        if(Random.Range(0, 10000) < 50)
        {
            goalPos = new Vector3(Random.Range(-cageSize, cageSize), Random.Range(-cageSize, cageSize), Random.Range(-cageSize, cageSize));
        }
    }
}
