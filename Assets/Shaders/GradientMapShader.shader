Shader "Custom/Gradient Map Shader" 
{
	Properties 
	{
		//Provide two images, the main texture and the gradient map(s)
		_MainTex ("Base (RGBA)", 2D) = "white" {}
		_ColorRamp ("Color Ramp", 2D) = "white" {}
		
		//Vectors correspond to RGBA channels of an image
		_RedChannelMask("Red Channel Mask", Vector) = (1, 0, 0, 0)
		_BlueChannelMask("Blue Channel Mask", Vector) = (0, 1, 0, 0)
		_GreenChannelMask("Green Channel Mask", Vector) = (0, 0, 1, 0)
		_AlphaChannelMask("Alpha Channel Mask", Vector) = (0, 0, 0, 1)
		
		//Specifies the UV Space where each channel is stored
		//R: 0-1, B: 1-2, G: 2-3, A: 3-4
		_GreenUVOffset("Green UV Offset", float) = 1
		_BlueUVOffset("Blue UV Offset", float) = 2
		_AlphaUVOffset("Alpha UV Offset", float) = 3
		
		//Picks a color in the ramp texture by adjusting y value
		_RedUVY("Red UVs Color",  Range (0, 1)) = 0
		_GreenUVY("Green UVs Color", Range(0, 1)) = 0
		_BlueUVY("Blue UVs Color", Range(0, 1)) = 0
		_AlphaUVY("Alpha UVs Color", Range(0, 1)) = 0
		
	}
	
	SubShader
	{
		Tags { "RenderType"="Opaque" }
		LOD 200
		
		CGPROGRAM
		#pragma surface surf Lambert

		uniform sampler2D _MainTex;
		uniform sampler2D _ColorRamp;
		
		uniform float4 _RedChannelMask;
		uniform float4 _BlueChannelMask;
		uniform float4 _GreenChannelMask;
		uniform float4 _AlphaChannelMask;
		
		uniform float _GreenUVOffset;
		uniform float _BlueUVOffset;
		uniform float _AlphaUVOffset;
		
		uniform float _RedUVY;
		uniform float _GreenUVY;
		uniform float _BlueUVY;
		uniform float _AlphaUVY;

		struct Input 
		{
			float2 uv_MainTex;
		};

		void surf (Input IN, inout SurfaceOutput o) 
		{
			float value = 0;
			float yUV;
			
			//Determine what color to apply to the texture by UV position
			if(IN.uv_MainTex.x < _GreenUVOffset)
			{
				half4 c = tex2D (_MainTex, IN.uv_MainTex);
				value = dot(c, _RedChannelMask);
				yUV = _RedUVY;
			}
			
			if(IN.uv_MainTex.x > _GreenUVOffset && IN.uv_MainTex.x < _BlueUVOffset)
			{
				float2 modifiedUVs = IN.uv_MainTex;
				
				half4 c = tex2D (_MainTex, modifiedUVs);
				value = dot(c, _GreenChannelMask);
				yUV = _GreenUVY;
			}
			
			if(IN.uv_MainTex.x > _BlueUVOffset && IN.uv_MainTex.x < _AlphaUVOffset)
			{
				float2 modifiedUVs = IN.uv_MainTex;
				
				half4 c = tex2D (_MainTex, modifiedUVs);
				value = dot(c, _BlueChannelMask);
				yUV = _BlueUVY;
			}
			
			if(IN.uv_MainTex.x > _AlphaUVOffset)
			{
				float2 modifiedUVs = IN.uv_MainTex;
				
				half4 c = tex2D (_MainTex, modifiedUVs);
				value = dot(c, _AlphaChannelMask);
				yUV = _AlphaUVY;
			}
			
			
			o.Albedo = tex2D(_ColorRamp, float2(value, yUV)).rgb;
			o.Alpha = 1;
		}
		ENDCG
	} 
	FallBack "Diffuse"
}
