// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
Shader "Butterfly_VertexOffsetV3"
{
	Properties
	{
		_Amplitude("Amplitude", Float) = 0
		_Frequency("Frequency", Float) = 0
		_Freq("Freq", Float) = 0
		_TimeOffset("Time Offset", Float) = 0
		_AmplitudeOffset("Amplitude Offset", Float) = 0
		_YPositionOffset("YPositionOffset", Float) = 0
		_PositionalAmpScalar("Positional Amp Scalar", Float) = 0
		_Amp("Amp", Float) = 0
		_TextureSample0("Texture Sample 0", 2D) = "white" {}
		[HideInInspector] _texcoord( "", 2D ) = "white" {}
		[HideInInspector] __dirty( "", Int ) = 1
	}

	SubShader
	{
		Tags{ "RenderType" = "Transparent"  "Queue" = "Transparent+0" "IgnoreProjector" = "True" "IsEmissive" = "true"  }
		Cull Off
		CGINCLUDE
		#include "UnityShaderVariables.cginc"
		#include "UnityPBSLighting.cginc"
		#include "Lighting.cginc"
		#pragma target 3.0
		struct Input
		{
			float2 uv_texcoord;
		};

		uniform float _Amplitude;
		uniform float _Frequency;
		uniform float _TimeOffset;
		uniform float _YPositionOffset;
		uniform float _PositionalAmpScalar;
		uniform float _AmplitudeOffset;
		uniform float _Freq;
		uniform float _Amp;
		uniform sampler2D _TextureSample0;
		uniform float4 _TextureSample0_ST;

		void vertexDataFunc( inout appdata_full v, out Input o )
		{
			UNITY_INITIALIZE_OUTPUT( Input, o );
			float3 ase_vertex3Pos = v.vertex.xyz;
			float4 appendResult13 = (float4(0.0 , ( ( _Amplitude * sin( ( ( _Frequency * _Time.y ) + _TimeOffset + ( ase_vertex3Pos.y * _YPositionOffset ) ) ) * ( ase_vertex3Pos.y * _PositionalAmpScalar ) * v.color.b ) + _AmplitudeOffset ) , ( ( ( ase_vertex3Pos.y * sin( ( _Freq * _Time.y ) ) * v.color.r ) * _Amp ) + 0.0 ) , 0.0));
			v.vertex.xyz += appendResult13.xyz;
		}

		void surf( Input i , inout SurfaceOutputStandard o )
		{
			float2 uv_TextureSample0 = i.uv_texcoord * _TextureSample0_ST.xy + _TextureSample0_ST.zw;
			float4 tex2DNode38 = tex2D( _TextureSample0, uv_TextureSample0 );
			o.Emission = tex2DNode38.rgb;
			o.Alpha = tex2DNode38.a;
		}

		ENDCG
		CGPROGRAM
		#pragma surface surf Standard alpha:fade keepalpha fullforwardshadows vertex:vertexDataFunc 

		ENDCG
		Pass
		{
			Name "ShadowCaster"
			Tags{ "LightMode" = "ShadowCaster" }
			ZWrite On
			CGPROGRAM
			#pragma vertex vert
			#pragma fragment frag
			#pragma target 3.0
			#pragma multi_compile_shadowcaster
			#pragma multi_compile UNITY_PASS_SHADOWCASTER
			#pragma skip_variants FOG_LINEAR FOG_EXP FOG_EXP2
			#include "HLSLSupport.cginc"
			#if ( SHADER_API_D3D11 || SHADER_API_GLCORE || SHADER_API_GLES || SHADER_API_GLES3 || SHADER_API_METAL || SHADER_API_VULKAN )
				#define CAN_SKIP_VPOS
			#endif
			#include "UnityCG.cginc"
			#include "Lighting.cginc"
			#include "UnityPBSLighting.cginc"
			sampler3D _DitherMaskLOD;
			struct v2f
			{
				V2F_SHADOW_CASTER;
				float2 customPack1 : TEXCOORD1;
				float3 worldPos : TEXCOORD2;
				UNITY_VERTEX_INPUT_INSTANCE_ID
			};
			v2f vert( appdata_full v )
			{
				v2f o;
				UNITY_SETUP_INSTANCE_ID( v );
				UNITY_INITIALIZE_OUTPUT( v2f, o );
				UNITY_TRANSFER_INSTANCE_ID( v, o );
				Input customInputData;
				vertexDataFunc( v, customInputData );
				float3 worldPos = mul( unity_ObjectToWorld, v.vertex ).xyz;
				half3 worldNormal = UnityObjectToWorldNormal( v.normal );
				o.customPack1.xy = customInputData.uv_texcoord;
				o.customPack1.xy = v.texcoord;
				o.worldPos = worldPos;
				TRANSFER_SHADOW_CASTER_NORMALOFFSET( o )
				return o;
			}
			half4 frag( v2f IN
			#if !defined( CAN_SKIP_VPOS )
			, UNITY_VPOS_TYPE vpos : VPOS
			#endif
			) : SV_Target
			{
				UNITY_SETUP_INSTANCE_ID( IN );
				Input surfIN;
				UNITY_INITIALIZE_OUTPUT( Input, surfIN );
				surfIN.uv_texcoord = IN.customPack1.xy;
				float3 worldPos = IN.worldPos;
				half3 worldViewDir = normalize( UnityWorldSpaceViewDir( worldPos ) );
				SurfaceOutputStandard o;
				UNITY_INITIALIZE_OUTPUT( SurfaceOutputStandard, o )
				surf( surfIN, o );
				#if defined( CAN_SKIP_VPOS )
				float2 vpos = IN.pos;
				#endif
				half alphaRef = tex3D( _DitherMaskLOD, float3( vpos.xy * 0.25, o.Alpha * 0.9375 ) ).a;
				clip( alphaRef - 0.01 );
				SHADOW_CASTER_FRAGMENT( IN )
			}
			ENDCG
		}
	}
	Fallback "Diffuse"
	CustomEditor "ASEMaterialInspector"
}
/*ASEBEGIN
Version=16301
28.8;75.2;1367;792;1726.609;868.3363;2.390084;True;False
Node;AmplifyShaderEditor.CommentaryNode;19;-870.744,-459.8533;Float;False;884.8055;697.9471;Adding the scale and offset time value to the vertex's y position;4;5;9;17;18;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;17;-829.1131,-81.15216;Float;False;548.8;291.1;Scales Vertex Z Position ;3;15;14;16;;1,1,1,1;0;0
Node;AmplifyShaderEditor.CommentaryNode;18;-839.3523,-410.2518;Float;False;457.4999;315.8;Scales and Offsets Time Input;4;6;8;2;7;;1,1,1,1;0;0
Node;AmplifyShaderEditor.PosVertexDataNode;14;-819.5423,-37.29148;Float;False;0;0;5;FLOAT3;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleTimeNode;2;-814.1293,-265.9636;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;16;-809.8442,128.1652;Float;False;Property;_YPositionOffset;YPositionOffset;5;0;Create;True;0;0;False;0;0;19.9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;7;-800.1609,-350.3735;Float;False;Property;_Frequency;Frequency;1;0;Create;True;0;0;False;0;0;9.1;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleTimeNode;32;-988.7745,665.4214;Float;False;1;0;FLOAT;1;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;31;-974.8066,581.0115;Float;False;Property;_Freq;Freq;2;0;Create;True;0;0;False;0;0;9;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;24;29.68491,209.5231;Float;False;570.0107;333.0326;Uses distance from origin as scalar mulitiplier of amplitude;2;26;23;;1,1,1,1;0;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;15;-439.6429,4.26516;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;6;-603.9287,-211.9633;Float;False;Property;_TimeOffset;Time Offset;3;0;Create;True;0;0;False;0;0;3.45;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;8;-602.4604,-352.2736;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;33;-777.1059,579.1115;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;23;60.55314,434.8065;Float;False;Property;_PositionalAmpScalar;Positional Amp Scalar;6;0;Create;True;0;0;False;0;0;1.38;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;34;-568.8751,574.0146;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.VertexColorNode;25;-750.534,280.3856;Float;True;0;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SimpleAddOpNode;9;-297.8614,-208.3955;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;20;112.2401,-350.1736;Float;False;521.0765;519.624;Scaling and Offsetting sin Output;4;11;4;10;3;;1,1,1,1;0;0
Node;AmplifyShaderEditor.RangedFloatNode;3;130.078,-256.5203;Float;False;Property;_Amplitude;Amplitude;0;0;Create;True;0;0;False;0;0;4.47;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;35;-303.2357,464.9493;Float;False;3;3;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;37;-97.37083,727.6417;Float;False;Property;_Amp;Amp;7;0;Create;True;0;0;False;0;0;0.83;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SinOpNode;5;-131.2319,-191.7933;Float;False;1;0;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;26;327.2135,277.3372;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;10;385.3139,50.71986;Float;False;Property;_AmplitudeOffset;Amplitude Offset;4;0;Create;True;0;0;False;0;0;0;0;0;0;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;4;303.4781,-244.0205;Float;False;4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleMultiplyOpNode;36;366.4605,600.2893;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;39;708.006,426.3492;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.SimpleAddOpNode;11;485.4465,-193.9304;Float;False;2;2;0;FLOAT;0;False;1;FLOAT;0;False;1;FLOAT;0
Node;AmplifyShaderEditor.CommentaryNode;21;814.9952,-165.338;Float;False;224.6914;185.9083;Applying result to X axis;1;13;;1,1,1,1;0;0
Node;AmplifyShaderEditor.DynamicAppendNode;13;858.9379,-123.4473;Float;False;FLOAT4;4;0;FLOAT;0;False;1;FLOAT;0;False;2;FLOAT;0;False;3;FLOAT;0;False;1;FLOAT4;0
Node;AmplifyShaderEditor.SamplerNode;38;663.8161,-450.294;Float;True;Property;_TextureSample0;Texture Sample 0;8;0;Create;True;0;0;False;0;None;b4ef59fe850981844a5253f37db1846f;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.StandardSurfaceOutputNode;0;1208.767,-352.6835;Float;False;True;2;Float;ASEMaterialInspector;0;0;Standard;Butterfly_VertexOffsetV3;False;False;False;False;False;False;False;False;False;False;False;False;False;False;True;False;False;False;False;False;Off;0;False;-1;0;False;-1;False;0;False;-1;0;False;-1;False;0;Transparent;0.5;True;True;0;False;Transparent;;Transparent;All;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;True;0;False;-1;False;0;False;-1;255;False;-1;255;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;-1;False;2;15;10;25;False;0.5;True;2;5;False;-1;10;False;-1;0;0;False;-1;0;False;-1;0;False;-1;0;False;-1;0;False;0;0,0,0,0;VertexOffset;True;False;Cylindrical;False;Relative;0;;-1;-1;-1;-1;0;False;0;0;False;-1;-1;0;False;-1;0;0;0;False;0.1;False;-1;0;False;-1;16;0;FLOAT3;0,0,0;False;1;FLOAT3;0,0,0;False;2;FLOAT3;0,0,0;False;3;FLOAT;0;False;4;FLOAT;0;False;5;FLOAT;0;False;6;FLOAT3;0,0,0;False;7;FLOAT3;0,0,0;False;8;FLOAT;0;False;9;FLOAT;0;False;10;FLOAT;0;False;13;FLOAT3;0,0,0;False;11;FLOAT3;0,0,0;False;12;FLOAT3;0,0,0;False;14;FLOAT4;0,0,0,0;False;15;FLOAT3;0,0,0;False;0
WireConnection;15;0;14;2
WireConnection;15;1;16;0
WireConnection;8;0;7;0
WireConnection;8;1;2;0
WireConnection;33;0;31;0
WireConnection;33;1;32;0
WireConnection;34;0;33;0
WireConnection;9;0;8;0
WireConnection;9;1;6;0
WireConnection;9;2;15;0
WireConnection;35;0;14;2
WireConnection;35;1;34;0
WireConnection;35;2;25;1
WireConnection;5;0;9;0
WireConnection;26;0;14;2
WireConnection;26;1;23;0
WireConnection;4;0;3;0
WireConnection;4;1;5;0
WireConnection;4;2;26;0
WireConnection;4;3;25;3
WireConnection;36;0;35;0
WireConnection;36;1;37;0
WireConnection;39;0;36;0
WireConnection;11;0;4;0
WireConnection;11;1;10;0
WireConnection;13;1;11;0
WireConnection;13;2;39;0
WireConnection;0;2;38;0
WireConnection;0;9;38;4
WireConnection;0;11;13;0
ASEEND*/
//CHKSM=132F25DBA962B25733934539B1A75424832F89AA