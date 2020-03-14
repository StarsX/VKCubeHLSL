//--------------------------------------------------------------------------------------
// By S. XU Tianchen
//--------------------------------------------------------------------------------------

struct PSIn
{
	float3 Nrm : NORMAL;
	float2 Tex : TEXCOORD;
};

struct PSOut
{
	float4 Albedo : SV_TARGET0;
	float4 Normal : SV_TARGET1;
};

SamplerState	g_smpLinear	: register(s0, space1);
Texture2D		g_txDiffuse	: register(t0, space2);

PSOut main(PSIn input)
{
	PSOut output;

	output.Albedo = g_txDiffuse.Sample(g_smpLinear, input.Tex);
	output.Normal = float4(normalize(input.Nrm) * 0.5 + 0.5, 1.0);

	return output;
}
