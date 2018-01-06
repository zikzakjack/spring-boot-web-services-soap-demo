package zikzakjack.services;

import java.util.ArrayList;
import java.util.Iterator;
import java.util.List;

import org.springframework.stereotype.Component;

import zikzakjack.domain.Region;

@Component
public class RegionService {

	private static List<Region> regions = new ArrayList<Region>();

	static {
		regions.add(new Region(1, "ASIA"));
		regions.add(new Region(2, "AMER"));
		regions.add(new Region(3, "APAC"));
		regions.add(new Region(4, "GLOBAL"));
	}

	public Region findByRegionId(int regionId) {
		for (Region region : regions) {
			if (region.getRegionId() == regionId)
				return region;
		}
		return null;
	}

	public List<Region> findAllRegion() {
		return regions;
	}

	public int deleteByRegionId(int regionId) {
		Iterator<Region> iterator = regions.iterator();
		while (iterator.hasNext()) {
			Region region = iterator.next();
			if (region.getRegionId() == regionId)
				regions.remove(region);
			return 1;
		}
		return 0;
	}

}
