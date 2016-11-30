pro hmi_full2sub_map, directory, submap_range

restore, directory+'full-disc-map.sav'
submap_range = [205.,-222.]
sub_map, map, xr=[submap_range[0] - 50.,submap_range[0] + 50.], yr=[submap_range[1] - 50.,submap_range[1] + 50.], mp


end
