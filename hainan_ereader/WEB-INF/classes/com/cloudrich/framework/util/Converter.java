package com.cloudrich.framework.util;

public class Converter {

	public double PI = 3.14159265358979324 ;
	public double[] gcj_decrypt_exact(double gcjLat,double gcjLon)
	{
		double initDelta = 0.01;
		double threshold = 0.000000001;
		double dLat = initDelta, dLon = initDelta;
		double mLat = gcjLat - dLat, mLon = gcjLon - dLon;
		double pLat = gcjLat + dLat, pLon = gcjLon + dLon;
		double wgsLat, wgsLon, i = 0;
		while (true) {
            wgsLat = (mLat + pLat) / 2;
            wgsLon = (mLon + pLon) / 2;
            double[] tmp = this.gcj_encrypt(wgsLat, wgsLon);
            dLat = tmp[0] - gcjLat;
            dLon = tmp[1] - gcjLon;
            if ((Math.abs(dLat) < threshold) && (Math.abs(dLon) < threshold))
                break;
 
            if (dLat > 0) pLat = wgsLat; else mLat = wgsLat;
            if (dLon > 0) pLon = wgsLon; else mLon = wgsLon;
 
            if (++i > 10000) break;
        }
		double d[] = new double[2];
		d[0] = wgsLat ;
		d[1] = wgsLon;
		return d ;
	}
	 double[] gcj_encrypt (double wgsLat,double wgsLon) {
        
        double[] d = this.delta(wgsLat, wgsLon);
        d[0] = wgsLat + d[0];
        d[1] = wgsLon + d[1];
        
        return d;
    }
	
	public double[] gcj_decrypt(double gcjLat,double gcjLon){
		double[] d = this.delta(gcjLat, gcjLon);
		d[0] = gcjLat - d[0];
		d[1] = gcjLon - d[1];
		
        return d;
	}
	
	double[] delta (double lat,double lon) {
        // Krasovsky 1940
        //
        // a = 6378245.0, 1/f = 298.3
        // b = a * (1 - f)
        // ee = (a^2 - b^2) / a^2;
        double a = 6378245.0; //  a: �����������ͶӰ��ƽ���ͼ���ϵ��ͶӰ���ӡ�
        double ee = 0.00669342162296594323; //  ee: �����ƫ���ʡ�
        double dLat = this.transformLat(lon - 105.0, lat - 35.0);
        double dLon = this.transformLon(lon - 105.0, lat - 35.0);
        double radLat = lat / 180.0 * this.PI;
        double magic = Math.sin(radLat);
        magic = 1 - ee * magic * magic;
        double sqrtMagic = Math.sqrt(magic);
        dLat = (dLat * 180.0) / ((a * (1 - ee)) / (magic * sqrtMagic) * this.PI);
        dLon = (dLon * 180.0) / (a / sqrtMagic * Math.cos(radLat) * this.PI);
        double d[] = new double[2];
        d[0] = dLat ;
        d[1] = dLon ;
        
        return d;
    }
	
	   double transformLat (double x,double y) {
        double ret = -100.0 + 2.0 * x + 3.0 * y + 0.2 * y * y + 0.1 * x * y + 0.2 * Math.sqrt(Math.abs(x));
        ret += (20.0 * Math.sin(6.0 * x * this.PI) + 20.0 * Math.sin(2.0 * x * this.PI)) * 2.0 / 3.0;
        ret += (20.0 * Math.sin(y * this.PI) + 40.0 * Math.sin(y / 3.0 * this.PI)) * 2.0 / 3.0;
        ret += (160.0 * Math.sin(y / 12.0 * this.PI) + 320 * Math.sin(y * this.PI / 30.0)) * 2.0 / 3.0;
        return ret;
    }
	   double transformLon (double x,double y) {
        double ret = 300.0 + x + 2.0 * y + 0.1 * x * x + 0.1 * x * y + 0.1 * Math.sqrt(Math.abs(x));
        ret += (20.0 * Math.sin(6.0 * x * this.PI) + 20.0 * Math.sin(2.0 * x * this.PI)) * 2.0 / 3.0;
        ret += (20.0 * Math.sin(x * this.PI) + 40.0 * Math.sin(x / 3.0 * this.PI)) * 2.0 / 3.0;
        ret += (150.0 * Math.sin(x / 12.0 * this.PI) + 300.0 * Math.sin(x / 30.0 * this.PI)) * 2.0 / 3.0;
        return ret;
    }
	   
	   public static void main(String[] args) {
		   Converter d = new Converter();
		   double f[] = d.gcj_decrypt_exact(18.633472, 109.698302);
		   System.out.println(f[0]);
		   System.out.println(f[1]);
		   
			
	}
}
