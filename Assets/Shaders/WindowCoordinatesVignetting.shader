﻿Shader "Custom/WindowCoordinates/Vignetting" {
    SubShader {
        Pass {
            CGPROGRAM

            #pragma vertex vert
            #pragma fragment frag
            #pragma target 3.0

            #include "UnityCG.cginc"

            float4 vert(appdata_base v) : POSITION {
                return mul (UNITY_MATRIX_MVP, v.vertex);
            }

            float4 frag(float4 sp:WPOS) : COLOR {
                float2 wcoord = sp.xy/_ScreenParams.xy;
                float vig = clamp(3.0*length(wcoord-0.5),0.0,1.0);
                return lerp (float4(wcoord,0.0,1.0),float4(0.3,0.3,0.3,1.0),vig);
            }
            ENDCG
        }
    }
}