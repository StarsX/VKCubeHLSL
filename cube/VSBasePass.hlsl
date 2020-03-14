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
	float4x4 g_worldViewProj;
	float4x4 g_world;
	float3x3 g_worldIT;
};

VSOut main(VSIn input) 
{
	VSOut output;

	output.Nrm = normalize(mul(g_worldIT, input.Nrm));
	output.Tex = input.Tex.xy;

	output.Pos = mul(g_worldViewProj, input.Pos);

	return output;
}
