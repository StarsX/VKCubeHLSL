//--------------------------------------------------------------------------------------
// By S. XU Tianchen
//--------------------------------------------------------------------------------------

struct PSIn
{
	float3 Nrm	: location0;
	float2 Tex	: location1;
};

SamplerState	g_smpLinear		: register(s1);
Texture2D		g_txDiffuse		: register(t2);

void main(PSIn input,
	out float4 Results[2] : SV_TARGET)
{
	Results[0] = g_txDiffuse.Sample(g_smpLinear, input.Tex);
	Results[1] = float4(normalize(input.Nrm) * 0.5 + 0.5, 1.0);
}
