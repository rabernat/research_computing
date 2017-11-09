"""
A python module for computing great circle distance
"""
import numpy as np

# approximate radius of Earth
R = 6.371e6

def great_circle_distance(point1, point2):
    """Calculate great-circle distance between two points.
    
    PARAMETERS
    ----------
    point1 : tuple
        A (lat, lon) pair of coordinates in degrees
    point2 : tuple
        A (lat, lon) pair of coordinates in degrees
        
    RETURNS
    -------
    distance : float
    """
    
    # unpack coordinates
    lat1, lon1 = point1
    lat2, lon2 = point2
    
    # unpack and convert everything to radians
    phi1, lambda1, phi2, lambda2 = [np.deg2rad(v) for v in 
                                    (point1 + point2)]
    
    
    # apply formula
    # https://en.wikipedia.org/wiki/Great-circle_distance
    return R*np.arccos(
        np.sin(phi1)*np.sin(phi2) + 
        np.cos(phi1)*np.cos(phi2)*np.cos(lambda2 - lambda1))

    
    