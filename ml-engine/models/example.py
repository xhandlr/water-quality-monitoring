from sklearn.ensemble import IsolationForest
import pandas as pd

def detect_anomalies(sensor_data):
    """Encuentra mediciones raras automáticamente"""
    model = IsolationForest(contamination=0.1, random_state=42)
    predictions = model.fit_predict(sensor_data)
    
    # -1 = anomalía, 1 = normal
    anomalies = sensor_data[predictions == -1]
    return anomalies