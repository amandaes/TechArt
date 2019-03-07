using System.Collections;
using System.Collections.Generic;
using UnityEngine;

public class NoiseMapGeneration : MonoBehaviour
{
   public float[,] Noise (int chunkDepth, int chunkWidth, float scale)
    {
        float[,] noiseMap = new float[chunkDepth, chunkWidth];
        for (int z = 0; z < chunkDepth; z++)
        {
            for (int x = 0; x < chunkWidth; x++)
            {
                float sampleX = x / scale;
                float sampleZ = z / scale;

                float noise = Mathf.PerlinNoise(sampleX, sampleZ);
                noiseMap[x, z] = noise;
            }
        }
        return noiseMap;
    }
}
