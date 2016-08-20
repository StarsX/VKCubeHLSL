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

cbuffer cbMatrices : register(b0)
{
	float4x4 g_mWorldViewProj;
	float4x4 g_mWorld;
	float3x3 g_mWorldIT;
};

void main(VSIn input,
	out float4 Pos	: SV_Position,
	out float3 Nrm	: NORMAL,
	out float2 Tex	: TEXCOORD) 
{
	Nrm = normalize(mul(g_mWorldIT, input.Nrm));
	Tex = input.Tex.xy;

	Pos = mul(g_mWorldViewProj, input.Pos);
}
