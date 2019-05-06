// Made with Amplify Shader Editor
// Available at the Unity Asset Store - http://u3d.as/y3X 
// Upgrade NOTE: replaced 'mul(UNITY_MATRIX_MVP,*)' with 'UnityObjectToClipPos(*)'

Shader "PostProcessAmp"
{
	Properties
	{
		_MainTex ( "Screen", 2D ) = "black" {}
		_Pixelx("Pixel x", Range( 0 , 5000)) = 441
		_PixelY("Pixel Y", Range( 0 , 5000)) = 882
	}

	SubShader
	{
		
		
		ZTest Always
		Cull Off
		ZWrite Off

		
		Pass
		{ 
			CGPROGRAM 

			#pragma vertex vert_img_custom 
			#pragma fragment frag
			#pragma target 3.0
			#include "UnityCG.cginc"
			

			struct appdata_img_custom
			{
				float4 vertex : POSITION;
				half2 texcoord : TEXCOORD0;
				
			};

			struct v2f_img_custom
			{
				float4 pos : SV_POSITION;
				half2 uv   : TEXCOORD0;
				half2 stereoUV : TEXCOORD2;
		#if UNITY_UV_STARTS_AT_TOP
				half4 uv2 : TEXCOORD1;
				half4 stereoUV2 : TEXCOORD3;
		#endif
				
			};

			uniform sampler2D _MainTex;
			uniform half4 _MainTex_TexelSize;
			uniform half4 _MainTex_ST;
			
			uniform float _Pixelx;
			uniform float _PixelY;

			v2f_img_custom vert_img_custom ( appdata_img_custom v  )
			{
				v2f_img_custom o;
				
				o.pos = UnityObjectToClipPos ( v.vertex );
				o.uv = float4( v.texcoord.xy, 1, 1 );

				#if UNITY_UV_STARTS_AT_TOP
					o.uv2 = float4( v.texcoord.xy, 1, 1 );
					o.stereoUV2 = UnityStereoScreenSpaceUVAdjust ( o.uv2, _MainTex_ST );

					if ( _MainTex_TexelSize.y < 0.0 )
						o.uv.y = 1.0 - o.uv.y;
				#endif
				o.stereoUV = UnityStereoScreenSpaceUVAdjust ( o.uv, _MainTex_ST );
				return o;
			}

			half4 frag ( v2f_img_custom i ) : SV_Target
			{
				#ifdef UNITY_UV_STARTS_AT_TOP
					half2 uv = i.uv2;
					half2 stereoUV = i.stereoUV2;
				#else
					half2 uv = i.uv;
					half2 stereoUV = i.stereoUV;
				#endif	
				
				half4 finalColor;

				// ase common template code
				float2 uv06 = i.uv.xy * float2( 1,1 ) + float2( 0,0 );
				float pixelWidth5 =  1.0f / _Pixelx;
				float pixelHeight5 = 1.0f / _PixelY;
				half2 pixelateduv5 = half2((int)(uv06.x / pixelWidth5) * pixelWidth5, (int)(uv06.y / pixelHeight5) * pixelHeight5);
				

				finalColor = tex2D( _MainTex, pixelateduv5 );

				return finalColor;
			} 
			ENDCG 
		}
	}
	CustomEditor "ASEMaterialInspector"
	
	
}
/*ASEBEGIN
Version=16600
66.8;52;1109;710;1649.511;726.1154;1.894917;True;False
Node;AmplifyShaderEditor.TextureCoordinatesNode;6;-1012.15,-43.66319;Float;False;0;-1;2;3;2;SAMPLER2D;;False;0;FLOAT2;1,1;False;1;FLOAT2;0,0;False;5;FLOAT2;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.RangedFloatNode;7;-1036.953,102.6584;Float;False;Property;_Pixelx;Pixel x;0;0;Create;True;0;0;False;0;441;0;0;5000;0;1;FLOAT;0
Node;AmplifyShaderEditor.RangedFloatNode;8;-1032.027,204.8734;Float;False;Property;_PixelY;Pixel Y;1;0;Create;True;0;0;False;0;882;0;0;5000;0;1;FLOAT;0
Node;AmplifyShaderEditor.TFHCPixelate;5;-624.0019,-21.14119;Float;False;3;0;FLOAT2;0,0;False;1;FLOAT;0;False;2;FLOAT;0;False;1;FLOAT2;0
Node;AmplifyShaderEditor.TemplateShaderPropertyNode;10;-431.0796,-161.4301;Float;False;0;0;_MainTex;Shader;0;5;SAMPLER2D;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.SamplerNode;9;-184.7402,-79.9487;Float;True;Property;_TextureSample0;Texture Sample 0;2;0;Create;True;0;0;False;0;None;None;True;0;False;white;Auto;False;Object;-1;Auto;Texture2D;6;0;SAMPLER2D;;False;1;FLOAT2;0,0;False;2;FLOAT;0;False;3;FLOAT2;0,0;False;4;FLOAT2;0,0;False;5;FLOAT;1;False;5;COLOR;0;FLOAT;1;FLOAT;2;FLOAT;3;FLOAT;4
Node;AmplifyShaderEditor.TemplateMultiPassMasterNode;0;276,-95;Float;False;True;2;Float;ASEMaterialInspector;0;2;PostProcessAmp;c71b220b631b6344493ea3cf87110c93;True;SubShader 0 Pass 0;0;0;SubShader 0 Pass 0;1;False;False;False;True;2;False;-1;False;False;True;2;False;-1;True;7;False;-1;False;True;0;False;0;False;False;False;False;False;False;False;False;False;False;True;2;0;;0;0;Standard;0;0;1;True;False;1;0;FLOAT4;0,0,0,0;False;0
WireConnection;5;0;6;0
WireConnection;5;1;7;0
WireConnection;5;2;8;0
WireConnection;9;0;10;0
WireConnection;9;1;5;0
WireConnection;0;0;9;0
ASEEND*/
//CHKSM=72F09AFC387F42C9BEFD0D1BB04F3748A1907E15