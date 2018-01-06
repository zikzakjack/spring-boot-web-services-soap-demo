package zikzakjack.domain;

import java.io.Serializable;

public class Region implements Serializable, Comparable<Region> {

	private static final long serialVersionUID = 1L;

	private Integer regionId;

	private String regionName;

	public Region() {
	}

	public Region(Integer regionId, String regionName) {
		this.regionId = regionId;
		this.regionName = regionName;
	}

	public Region(String regionName) {
		this.regionName = regionName;
	}

	public Integer getRegionId() {
		return regionId;
	}

	public void setRegionId(Integer regionId) {
		this.regionId = regionId;
	}

	public String getRegionName() {
		return regionName;
	}

	public void setRegionName(String regionName) {
		this.regionName = regionName;
	}

	@Override
	public boolean equals(Object obj) {
		if (this == obj)
			return true;
		if (obj == null)
			return false;
		if (getClass() != obj.getClass())
			return false;
		Region other = (Region) obj;
		if (regionId == null) {
			if (other.regionId != null)
				return false;
		} else if (!regionId.equals(other.regionId))
			return false;
		if (regionName == null) {
			if (other.regionName != null)
				return false;
		} else if (!regionName.equals(other.regionName))
			return false;
		return true;
	}

	@Override
	public int hashCode() {
		final int prime = 31;
		int result = 1;
		result = prime * result + ((regionId == null) ? 0 : regionId.hashCode());
		result = prime * result + ((regionName == null) ? 0 : regionName.hashCode());
		return result;
	}

	@Override
	public String toString() {
		return "Region [regionId=" + regionId + ", regionName=" + regionName + "]";
	}

	@Override
	public int compareTo(Region o) {
		return regionId.compareTo(o.regionId);
	}

}
