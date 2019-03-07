using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class CubeTreadmill : MonoBehaviour
{
    public GameObject terrainMesh;

    public GameObject target;

    private List<GameObject> terrainChunks;

    private Vector3 _intPos;
    private Vector3 _currentIntPos;
    private Vector3 _oldIntPos;

    

    void Start()
    {   

        terrainChunks = new List<GameObject>();
        for (int i = 0; i < 3; i++)
        {
            for (int j = 0; j < 3; j++)
            {

                terrainChunks.Add(Instantiate(terrainMesh, new Vector3(j, 0, i), Quaternion.identity));

            }
        }

    }


    void Update()
    {
        

        _intPos = new Vector3(Mathf.Floor(target.transform.position.x), 0, Mathf.Floor(target.transform.position.z));

        if (_intPos != _oldIntPos)
        {
            if (_intPos.x > _oldIntPos.x) //if move to the right
            {
                foreach(GameObject g in terrainChunks)
                {
                   
                    g.transform.position += Vector3.right;
                }
            }
            if (_intPos.x < _oldIntPos.x) //if move to the left
            {
                foreach(GameObject g in terrainChunks)
                {
                    g.transform.position -= Vector3.right;
                }
            }
            if (_intPos.z > _oldIntPos.z) //if move to the front
            {
                foreach (GameObject g in terrainChunks)
                {
                    g.transform.position += Vector3.forward;
                }
            }
            if (_intPos.z < _oldIntPos.z) //if move to the back
            {
                foreach (GameObject g in terrainChunks)
                {
                    g.transform.position -= Vector3.forward;
                }
            }

            _oldIntPos = _intPos;
        }
    }
}
