using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class InfiniteTerrain : MonoBehaviour
{
    #region Variables
    public const float maxViewDistance = 300f;
    public Transform target;
    public GameObject terrain;
    private static Vector3 targetPos;
    int chunkSize;
    int chunkVisibleInViewDist;
    #endregion

    Dictionary<Vector2, TerrainChunk> terrainChunkDictionary = new Dictionary<Vector2, TerrainChunk>();
    private List<TerrainChunk> terrainVisibleLastUpdate = new List<TerrainChunk>();

    // Start is called before the first frame update
    void Start()
    {
        chunkSize = CreateMesh.gridSize - 1;
        chunkVisibleInViewDist = Mathf.RoundToInt(maxViewDistance / chunkSize);
    }

    void Update()
    {
        targetPos = new Vector3(target.position.x, 0, target.position.z);
        UpdateVisibleChunks();
    }

    void UpdateVisibleChunks()
    {
        for (int i = 0; i < terrainVisibleLastUpdate.Count; i++)
        {
            terrainVisibleLastUpdate[i].SetVisible(false);
        }
        terrainVisibleLastUpdate.Clear();

        int currentChunkCoordX = Mathf.RoundToInt(targetPos.x / chunkSize);
        int currentChunkCoordZ = Mathf.RoundToInt(targetPos.z / chunkSize);

        for(int zOffset = -chunkVisibleInViewDist; zOffset <= chunkVisibleInViewDist; zOffset++)
        {
            for (int xOffset = -chunkVisibleInViewDist; xOffset <= chunkVisibleInViewDist; xOffset++)
            {
                Vector3 viewedChunkCoord = new Vector3(currentChunkCoordX + xOffset, 0, currentChunkCoordZ + zOffset);

                if (terrainChunkDictionary.ContainsKey(viewedChunkCoord))
                {
                    terrainChunkDictionary[viewedChunkCoord].UpdateTerrainChunk();
                }
                else
                {
                    terrainChunkDictionary.Add(viewedChunkCoord, new TerrainChunk(terrain, viewedChunkCoord, chunkSize));
                }
            }
        }
        
    }
  
    public class TerrainChunk
    {
        Vector3 position;
        GameObject meshObj;
        Bounds bounds;

        public TerrainChunk(GameObject chunkMesh, Vector3 coord, int size)
        {
            position = coord * size;
            
            bounds = new Bounds(position, Vector3.one * size);
            Vector3 positionV3 = new Vector3(position.x, 0, position.z);

            meshObj = Instantiate(chunkMesh, position, Quaternion.identity);
            meshObj.transform.position = positionV3;
            meshObj.transform.localScale = Vector3.one * size / 10f;
            //meshObj.transform.parent = parent;
            SetVisible(false);
            
        }

        public void UpdateTerrainChunk()
        {
            float targetDistFromNearestEdge = Mathf.Sqrt(bounds.SqrDistance(targetPos));
            bool visible = targetDistFromNearestEdge <= maxViewDistance;
            SetVisible(visible);
        }

        public void SetVisible(bool visible)
        {
            meshObj.SetActive(visible);
        }

        public bool IsVisible()
        {
            return meshObj.activeSelf;
        }

    }

}
