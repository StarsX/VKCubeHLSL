//--------------------------------------------------------------------------------------
// By S. XU Tianchen
//--------------------------------------------------------------------------------------

struct VSIn
{
	float4 Pos : location0;
	float3 Nrm : location1;
	float4 Tex : location2;
};

struct VSOut
{
	float4 Pos	: SV_Position;
	float3 Nrm	: location0;
	float2 Tex	: location1;
};

cbuffer cbMatrices : register(b0)
{
	float4x4 g_mWorldViewProj;
	float4x4 g_mWorld;
	float3x3 g_mWorldIT;
};

void main(VSIn input,
	out float4 Pos	: SV_Position,
	out float3 Nrm	: location0,
	out float2 Tex	: location1) 
{
	Nrm = normalize(mul(g_mWorldIT, input.Nrm));
	Tex = input.Tex.xy;

	Pos = mul(g_mWorldViewProj, input.Pos);
}
