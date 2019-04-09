// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BirdFly"
{
	Properties
	{
		_AnimFreq("AnimFreq", Float) = 20
		_AnimPeriod("AnimPeriod", Float) = 0
		_DistScalar("DistScalar", Float) = 0
		_AnimMagnitude("AnimMagnitude", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "black" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "TransparentCutout"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _AnimFreq;
		uniform float _AnimPeriod;
		uniform float _AnimMagnitude;
		uniform float _DistScalar;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_4_0 = abs( ase_vertex3Pos.x );
			float4 appendResult18 = (float4(0.0 , ( sin( ( ( ( _Time.y * 1 ) * _AnimFreq ) + ( temp_output_4_0 * _AnimPeriod ) ) ) * _AnimMagnitude * ( temp_output_4_0 * _DistScalar ) ) , 0.0 , 0.0));
			v.vertex.xyz += appendResult18.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode19 = tex2D( _TextureSample0, uv_TextureSample0 );
			o.Emission = tex2DNode19.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
122.4;112.8;1162;784;2831.06;1431.611;3.393757;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;7;-1014.172,175.6754;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1544.25,179.7018;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;12;-865.0958,476.9149;Float;False;Property;_AnimPeriod;AnimPeriod;2;0;Create;True;0;0;False;0;0;2;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;-730.6364,264.8834;Float;False;Property;_AnimFreq;AnimFreq;1;0;Create;True;0;0;False;0;20;20;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;4;-873.4744,363.2324;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ScaleNode;8;-725.4655,153.6962;Float;False;1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;2;-683.601,369.8823;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;9;-554.8063,147.2319;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;-385.4395,198.9467;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;15;-632.3787,516.9939;Float;False;Property;_DistScalar;DistScalar;3;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;13;-238.0514,186.018;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;17;-234.173,405.8067;Float;False;Property;_AnimMagnitude;AnimMagnitude;4;0;Create;True;0;0;False;0;0;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-433.2759,425.2;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;16;-98.42137,253.2475;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;40;-1251.977,-420.2831;Float;False;Constant;_Float3;Float 3;9;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;41;-1254.982,-347.1711;Float;False;Constant;_Float4;Float 4;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;25;-1549.41,2.298418;Float;False;Property;_Noise;Noise;6;0;Create;True;0;0;False;0;20;5;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;-23.65422,-287.7103;Float;True;2;2;0;COLOR;0,0,0,0;False;1;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.ObjectToWorldTransfNode;28;-1124.999,-70.54339;Float;False;1;0;FLOAT4;0,0,0,1;False;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TransformPositionNode;27;-1151.047,-253.0725;Float;False;Object;World;False;Fast;True;1;0;FLOAT3;0,0,0;False;4;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3
Node;AmplifyShaderEditor.RangedFloatNode;39;-1251.976,-497.4037;Float;False;Constant;_Float2;Float 2;9;0;Create;True;0;0;False;0;1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;42;-1140.53,-717.5793;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StepOpNode;32;-346.1552,-309.2984;Float;True;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;34;-881.5773,-291.6198;Float;False;Property;_edgewidth;edge width;7;0;Create;True;0;0;False;0;0.1;0.05;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;26;-890.4182,-118.4118;Float;True;2;2;0;FLOAT3;0,0,0;False;1;FLOAT4;0,0,0,0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.NoiseGeneratorNode;24;-592.8489,-149.4136;Float;True;Simplex3D;1;0;FLOAT3;0,0,0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;18;54.13789,239.0259;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.TFHCRemapNode;31;-912.228,-542.1988;Float;True;5;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;1;False;3;FLOAT;0;False;4;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.SamplerNode;19;-565.2281,-622.7021;Float;True;Property;_TextureSample0;Texture Sample 0;5;0;Create;True;0;0;False;0;851e849aef35b6b40bb81908bd677482;851e849aef35b6b40bb81908bd677482;True;0;False;black;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;33;-609.3166,-392.3393;Float;True;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;38;-1253.653,-574.5121;Float;False;Constant;_Float1;Float 1;9;0;Create;True;0;0;False;0;-1;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;29;-1336.987,21.93533;Float;False;2;2;0;FLOAT;0;False;1;FLOAT3;0,0,0;False;1;FLOAT3;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;655.2485,-275.1655;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;BirdFly;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;0.5;True;True;0;True;TransparentCutout;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;4;0;1;1
WireConnection;8;0;7;0
WireConnection;2;0;4;0
WireConnection;2;1;12;0
WireConnection;9;0;8;0
WireConnection;9;1;10;0
WireConnection;11;0;9;0
WireConnection;11;1;2;0
WireConnection;13;0;11;0
WireConnection;14;0;4;0
WireConnection;14;1;15;0
WireConnection;16;0;13;0
WireConnection;16;1;17;0
WireConnection;16;2;14;0
WireConnection;36;0;19;0
WireConnection;36;1;32;0
WireConnection;28;0;29;0
WireConnection;32;0;33;0
WireConnection;32;1;24;0
WireConnection;26;0;27;0
WireConnection;26;1;28;0
WireConnection;24;0;26;0
WireConnection;18;1;16;0
WireConnection;31;0;42;4
WireConnection;31;1;38;0
WireConnection;31;2;39;0
WireConnection;31;3;40;0
WireConnection;31;4;41;0
WireConnection;33;0;31;0
WireConnection;33;1;34;0
WireConnection;29;0;25;0
WireConnection;29;1;1;0
WireConnection;0;2;19;0
WireConnection;0;11;18;0
ASEEND*/
//CHKSM=E3BC0B4A91337B5C4D218CB1D88C7E6710735E22