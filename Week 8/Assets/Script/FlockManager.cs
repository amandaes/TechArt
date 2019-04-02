using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class FlockManager : MonoBehaviour
{

    public GameObject myAutoAgentPrefab;
    [Range(1, 500)] public int numberOfSpawns;
    List<GameObject> _allMyAgents = new List<GameObject>();


    // Start is called before the first frame update
    void Start()
    {
        float rCubed = 3 * numberOfSpawns / (4 * Mathf.PI * 2); //2 per unit volume
        float r = Mathf.Pow(rCubed, .33f);

        for(int i = 0; i < numberOfSpawns; i++)
        {
            _allMyAgents.Add(Instantiate(myAutoAgentPrefab, Random.insideUnitSphere * r, Quaternion.identity, transform));
        }
    }

    Collider[] collInRad = new Collider[1];

    // Update is called once per frame
    void Update()
    {
        
        foreach (GameObject g in _allMyAgents)
        {
           AutoAgentBehavior a = g.GetComponent<AutoAgentBehavior>(); //get reference to auto agent behavior

           Physics.OverlapSphereNonAlloc(g.transform, 5, collInRad);

            a.PassArrayOfContext(collInRad);
        }
    }
}
