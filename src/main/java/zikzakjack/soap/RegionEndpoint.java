package zikzakjack.soap;

import org.springframework.beans.factory.annotation.Autowired;
import org.springframework.ws.server.endpoint.annotation.Endpoint;
import org.springframework.ws.server.endpoint.annotation.PayloadRoot;
import org.springframework.ws.server.endpoint.annotation.RequestPayload;
import org.springframework.ws.server.endpoint.annotation.ResponsePayload;

import zikzakjack.domain.Region;
import zikzakjack.hrscott.GetRegionDetailsRequest;
import zikzakjack.hrscott.GetRegionDetailsResponse;
import zikzakjack.hrscott.RegionDetails;
import zikzakjack.services.RegionService;

@Endpoint
public class RegionEndpoint {
	
	@Autowired
	RegionService regionService;

	@PayloadRoot(namespace = "http://zikzakjack/hrscott", localPart = "getRegionDetailsRequest")
	@ResponsePayload
	public GetRegionDetailsResponse processRegionDetailsRequest(@RequestPayload GetRegionDetailsRequest request) {
		Region region = regionService.findByRegionId(request.getRegionId());
		return mapRegion(region);
	}

	private GetRegionDetailsResponse mapRegion(Region region) {
		GetRegionDetailsResponse response = new GetRegionDetailsResponse();
		RegionDetails regionDetails = new RegionDetails();
		regionDetails.setRegionId(region.getRegionId());
		regionDetails.setRegionName(region.getRegionName());
		response.setRegion(regionDetails);
		return response;
	}

}
