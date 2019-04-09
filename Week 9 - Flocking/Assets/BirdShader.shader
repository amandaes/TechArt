// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "BirdShader"
{
	Properties
	{
		_AnimMagnitude("Anim Magnitude", Float) = 1
		_AnimPeriod("Anim Period", Float) = 2
		_AnimFrequency("Anim Frequency", Float) = 16
		_DistanceScalar("Distance Scalar", Float) = 1
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Custom"  "Queue" = "Transparent+0" "IsEmissive" = "true"  }
		Cull Off
		Blend SrcAlpha OneMinusSrcAlpha
		
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float _AnimFrequency;
		uniform float _AnimPeriod;
		uniform float _AnimMagnitude;
		uniform float _DistanceScalar;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float temp_output_17_0 = abs( ase_vertex3Pos.x );
			float4 appendResult15 = (float4(0.0 , ( sin( ( ( ( _Time.y * 1 ) * _AnimFrequency ) + ( temp_output_17_0 * _AnimPeriod ) ) ) * _AnimMagnitude * ( temp_output_17_0 * _DistanceScalar ) ) , 0.0 , 0.0));
			v.vertex.xyz += appendResult15.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color16 = IsGammaSpace() ? float4(0,0.7075472,0.7023447,0) : float4(0,0.4588115,0.4513347,0);
			float4 color20 = IsGammaSpace() ? float4(0.5471698,0.1884122,0.328438,0) : float4(0.2603273,0.02960845,0.08811758,0);
			float4 lerpResult19 = lerp( color16 , color20 , (_SinTime.w*0.5 + 0.5));
			o.Emission = lerpResult19.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16400
54.8;52.8;1162;784;2037.917;-213.891;1.6;True;False
Node;AmplifyShaderEditor.SimpleTimeNode;2;-1442.44,701.2906;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.PosVertexDataNode;1;-1640.287,798.9192;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleNode;18;-1203.153,724.9149;Float;False;1;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.AbsOpNode;17;-1224.866,920.1693;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;3;-1246.241,809.6909;Float;False;Property;_AnimFrequency;Anim Frequency;3;0;Create;True;0;0;False;0;16;12;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;4;-1242.041,1030.291;Float;False;Property;_AnimPeriod;Anim Period;2;0;Create;True;0;0;False;0;2;10.97;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;6;-1012.241,723.8903;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;5;-1007.041,887.6912;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;8;-845.8434,726.4903;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;9;-942.5618,1065.362;Float;False;Property;_DistanceScalar;Distance Scalar;4;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;12;-775.6417,826.5908;Float;False;Property;_AnimMagnitude;Anim Magnitude;0;0;Create;True;0;0;False;0;1;1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;11;-695.0431,726.4907;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;30;-898.7534,421.0672;Float;False;Constant;_Float0;Float 0;7;0;Create;True;0;0;False;0;0.5;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinTimeNode;21;-1072.575,308.7563;Float;False;0;5;FLOAT4;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;13;-708.5619,945.3619;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;14;-539.0421,725.1904;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;16;-851.4814,-120.6886;Float;False;Constant;_Albedo;Albedo;5;0;Create;True;0;0;False;0;0,0.7075472,0.7023447,0;0.3915094,0.9724821,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.ScaleAndOffsetNode;29;-715.0045,261.1366;Float;False;3;0;FLOAT;0;False;1;FLOAT;1;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.ColorNode;20;-860.7625,56.53965;Float;False;Constant;_Color0;Color 0;6;0;Create;True;0;0;False;0;0.5471698,0.1884122,0.328438,0;0.3915094,0.9724821,1,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.LerpOp;19;-442.248,123.3552;Float;True;3;0;COLOR;0,0,0,0;False;1;COLOR;0,0,0,0;False;2;FLOAT;0;False;1;COLOR;0
Node;AmplifyShaderEditor.DynamicAppendNode;15;-362.2428,692.6908;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;-6.575619,219.1873;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;BirdShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Custom;1.06;True;True;0;True;Custom;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;18;0;2;0
WireConnection;17;0;1;1
WireConnection;6;0;18;0
WireConnection;6;1;3;0
WireConnection;5;0;17;0
WireConnection;5;1;4;0
WireConnection;8;0;6;0
WireConnection;8;1;5;0
WireConnection;11;0;8;0
WireConnection;13;0;17;0
WireConnection;13;1;9;0
WireConnection;14;0;11;0
WireConnection;14;1;12;0
WireConnection;14;2;13;0
WireConnection;29;0;21;4
WireConnection;29;1;30;0
WireConnection;29;2;30;0
WireConnection;19;0;16;0
WireConnection;19;1;20;0
WireConnection;19;2;29;0
WireConnection;15;1;14;0
WireConnection;0;2;19;0
WireConnection;0;11;15;0
ASEEND*/
//CHKSM=A20074AA2CA3F59466BBD2BD98E9362F663A22A6