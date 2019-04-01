// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "FishShader"
{
	Properties
	{
		_Amplitude("Amplitude", Float) = 0
		_Frequency("Frequency", Float) = 0
		_TimeOffset("Time Offset", Float) = 0
		_AmplitudeOffset("Amplitude Offset", Float) = 0
		_YPositionOffset("YPositionOffset", Float) = 0
		_PositionalAmpScalar("Positional Amp Scalar", Float) = 0
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Opaque"  "Queue" = "Geometry+0" "IgnoreProjector" = "True" }
		Cull Off
		CGPROGRAM
		#include "UnityShaderVariables.cginc"
		#pragma target 3.0
		#pragma surface surf Standard keepalpha addshadow fullforwardshadows vertex:vertexDataFunc 
		struct Input
		{
			half filler;
		};

		uniform float _Amplitude;
		uniform float _Frequency;
		uniform float _TimeOffset;
		uniform float _YPositionOffset;
		uniform float _PositionalAmpScalar;
		uniform float _AmplitudeOffset;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4 appendResult13 = (float4(( ( _Amplitude * sin( ( ( _Frequency * _Time.y ) + _TimeOffset + ( ase_vertex3Pos.z * _YPositionOffset ) ) ) * ( ase_vertex3Pos.z * _PositionalAmpScalar ) ) + _AmplitudeOffset ) , 0.0 , 0.0 , 0.0));
			v.vertex.xyz += appendResult13.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float4 color25 = IsGammaSpace() ? float4(0.4811321,0.3063813,0.4800014,0) : float4(0.196991,0.07643841,0.1959954,0);
			o.Albedo = color25.rgb;
			o.Alpha = 1;
		}

		ENDCG
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
67.6;130.8;1367;719;497.0482;652.4662;1.26074;True;False
Node;AmplifyShaderEditor.CommentaryNode;19;-870.744,-459.8533;Float;False;884.8055;697.9471;Adding the scale and offset time value to the vertex's y position;4;5;9;17;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;17;-829.1131,-81.15216;Float;False;578;287;Scales Vertex Z Position ;3;15;14;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-839.3523,-410.2518;Float;False;457.4999;315.8;Scales and Offsets Time Input;4;6;8;2;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-823.8425,-44.29148;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;16;-794.8442,121.1652;Float;False;Property;_YPositionOffset;YPositionOffset;4;0;Create;True;0;0;False;0;0;1.18;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;2;-814.1293,-265.9636;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-800.1609,-350.3735;Float;False;Property;_Frequency;Frequency;1;0;Create;True;0;0;False;0;0;1.7;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;24;-403.521,334.1418;Float;False;530;213;Uses distance from origin as scalar mulitiplier of amplitude;2;22;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-602.4604,-352.2736;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-603.9287,-211.9633;Float;False;Property;_TimeOffset;Time Offset;2;0;Create;True;0;0;False;0;0;3.45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-423.6427,-27.23484;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;-372.4541,447.5602;Float;False;Property;_PositionalAmpScalar;Positional Amp Scalar;5;0;Create;True;0;0;False;0;0;1.16;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-297.8614,-208.3955;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;20;75.16211,-322.8529;Float;False;491;346;Scaling and Offsetting sin Output;4;10;3;11;4;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;93.00002,-229.1997;Float;False;Property;_Amplitude;Amplitude;0;0;Create;True;0;0;False;0;0;4.41;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;5;-131.2319,-191.7933;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;22;-96.87754,411.7017;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;266.4001,-216.6999;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;200.5685,-73.8103;Float;False;Property;_AmplitudeOffset;Amplitude Offset;3;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;21;666.683,-196.5616;Float;False;236.5541;197.6083;Applying result to X axis;1;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;448.3684,-166.6098;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;710.6257,-154.6709;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.ColorNode;25;659.6692,-525.6194;Float;False;Constant;_Color0;Color 0;6;0;Create;True;0;0;False;0;0.4811321,0.3063813,0.4800014,0;0,0,0,0;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1120.693,-447.4319;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;FishShader;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Opaque;0.5;True;True;0;False;Opaque;;Geometry;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;0;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;0;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;8;0;7;0
WireConnection;8;1;2;0
WireConnection;15;0;14;3
WireConnection;15;1;16;0
WireConnection;9;0;8;0
WireConnection;9;1;6;0
WireConnection;9;2;15;0
WireConnection;5;0;9;0
WireConnection;22;0;14;3
WireConnection;22;1;23;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;4;2;22;0
WireConnection;11;0;4;0
WireConnection;11;1;10;0
WireConnection;13;0;11;0
WireConnection;0;0;25;0
WireConnection;0;11;13;0
ASEEND*/
//CHKSM=4D08D99FC6B5464FA44B525CBCD6470B4FD09904