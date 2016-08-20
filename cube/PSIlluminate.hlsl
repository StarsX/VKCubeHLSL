//--------------------------------------------------------------------------------------
// By S. XU Tianchen
//--------------------------------------------------------------------------------------

#if 0
cbuffer cbPerframe : register(b0)
{
	float4 g_vLightPos;
	float4 g_vEyePos;
};
#else
// This is wrong in HLSL, but glslang currently only support this style
cbuffer cbPerframe
{
	float4 vLightPos;
	float4 vEyePos;
} CBPerF : register(b0);
#define g_vLightPos	CBPerF.vLightPos
#define g_vEyePos	CBPerF.vEyePos
#endif

SamplerState	g_smpLinear		: register(s1);
Texture2D		g_txDiffuse		: register(t2);
Texture2D		g_txNormal		: register(t3);

void main(float2 Tex : TEXCOORD,
	out float4 Result : SV_TARGET)
{
	const float3 vUpDir = float3(0.0, 1.0, 0.0);
	const float4 vLight = 5.0.xxxx;
	const float4 vAmbient = 1.2.xxxx;

	float4 vDiffuse = g_txDiffuse.Sample(g_smpLinear, Tex);
	float4 vNorm = g_txNormal.Sample(g_smpLinear, Tex);
	vNorm.xyz = vNorm.xyz * 2.0 - 1.0;

	//float3 vLightDir = normalize(g_vLightPos.xyz - wpos);
	float3 vLightDir = normalize(g_vLightPos.xyz);

	float fLightAmt = saturate(dot(vNorm.xyz, vLightDir));
	float fAmbientAmt = saturate(dot(vNorm.xyz, vUpDir) * 0.5 + 0.5);
	float4 vLightColor = vLight * fLightAmt + vAmbient * fAmbientAmt;

	//float3 vViewDir = normalize(g_vEyePos.xyz - WPos);
	float3 vViewDir = normalize(g_vEyePos.xyz);
	float3 vHalfAngle = normalize(vLightDir + vViewDir);
	float fSpecAmt = saturate(dot(vNorm.xyz, vHalfAngle));
	float4 vSpec = pow(fSpecAmt, 32.0) * 1.0;

	Result = vLightColor * vDiffuse + vSpec;
	Result.w = vDiffuse.w;
	
	// Simple tone mapping
	Result.xyz /= Result.xyz + 1.0;
	Result.xyz *= Result.xyz;
}
