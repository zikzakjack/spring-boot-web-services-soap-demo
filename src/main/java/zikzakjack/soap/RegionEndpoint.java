package zikzakjack.soap;

import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;

import zikzakjack.hrscott.GetRegionRequest;
import zikzakjack.hrscott.GetRegionResponse;
import zikzakjack.hrscott.Region;

@Endpoint
public class RegionEndpoint {

	@PayloadRoot(namespace = "http://zikzakjack/hrscott", localPart = "GetRegionRequest")
	@ResponsePayload
	public GetRegionResponse processRegionRequest(@RequestPayload GetRegionRequest request) {
		GetRegionResponse response = new GetRegionResponse();
		Region region = new Region();
		region.setRegionId(99);
		region.setRegionName("Utopia");
		return response;
	}

}
