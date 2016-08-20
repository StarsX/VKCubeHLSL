//--------------------------------------------------------------------------------------
// By S. XU Tianchen
//--------------------------------------------------------------------------------------

struct VSIn
{
	float4 Pos : POSITION;
	float3 Nrm : NORMAL;
	float4 Tex : TEXCOORD;
};

struct VSOut
{
	float4 Pos	: SV_Position;
	float3 Nrm	: NORMAL;
	float2 Tex	: TEXCOORD;
};

#if 0
cbuffer cbMatrices : register(b0);
{
	float4x4 g_mWorldViewProj;
	float4x4 g_mWorld;
	float3x3 g_mWorldIT;
}
#else
// This is wrong in HLSL, but glslang currently only support this style
cbuffer cbMatrices
{
	float4x4 mWorldViewProj;
	float4x4 mWorld;
	float3x3 mWorldIT;
} CBMat : register(b0);
#define g_mWorldViewProj	CBMat.mWorldViewProj
#define g_mWorld			CBMat.mWorld
#define g_mWorldIT			CBMat.mWorldIT
#endif

void main(VSIn input,
	out float4 Pos	: SV_Position,
	out float3 Nrm	: NORMAL,
	out float2 Tex	: TEXCOORD) 
{
	Nrm = normalize(mul(g_mWorldIT, input.Nrm));
	Tex = input.Tex.xy;

	Pos = mul(g_mWorldViewProj, input.Pos);
}
