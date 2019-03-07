using System.Collections;
using System.Collections.Generic;
using UnityEngine;

[RequireComponent(typeof(MeshFilter))]
[RequireComponent(typeof(MeshRenderer))]
public class CreateMesh : MonoBehaviour
{
    #region Variables
    Mesh mesh;

    Vector3[] vertices;
    int[] triangles;
    Vector2[] uvs;
    Vector3[] normals;

    public static int gridSize = 20;
    private float mapScale;
    NoiseMapGeneration noiseMap;
    #endregion

    void Start()
    {
        mesh = new Mesh();
        GetComponent<MeshFilter>().mesh = mesh;

        CreateTerrain();
        UpdateTerrainMesh();

    }
    #region Terrain Chunk
    void CreateTerrain()
    {
        vertices = new Vector3[(gridSize + 1) * (gridSize + 1)];
        //ammount of vertices should be the number of grids + 1

        //float[,] heightMap = this.noiseMap.Noise(gridSize, gridSize, this.mapScale);
        //int i = 0;
        for (int i = 0, z = 0; z <= gridSize; z++)
        {
            for (int x = 0; x <= gridSize; x++)
            {
                //float y = heightMap(x, z);
                float y = Mathf.PerlinNoise(x * .4f, z * .4f) * 3f;
                vertices[i] = new Vector3(x, y, z);
                i++; 
            }
        }

        triangles = new int[gridSize * gridSize * 6];
        int vert = 0;
        int tris = 0;

        for (int z = 0; z< gridSize; z++)
        {
            for (int x = 0; x < gridSize; x++)
            {
                triangles[tris + 0] = vert + 0;
                triangles[tris + 1] = vert + gridSize + 1;
                triangles[tris + 2] = vert + 1;
                triangles[tris + 3] = vert + 1;
                triangles[tris + 4] = vert + gridSize + 1;  
                triangles[tris + 5] = vert + gridSize + 2;

                vert++;
                tris += 6;
            }
            vert++;
        }

        uvs = new Vector2[vertices.Length];
        
        for (int i = 0, z = 0; z <= gridSize; z++)
        {
            for (int x = 0; x <= gridSize; x++)
            {
                uvs[i] = new Vector2((float)x / gridSize, (float)z / gridSize);
                i++; 
            }
        }

    }

    void UpdateTerrainMesh()
    {
        mesh.Clear();

        mesh.vertices = vertices;
        mesh.triangles = triangles;
        mesh.uv = uvs;
        mesh.RecalculateNormals();
    }
    #endregion

}
