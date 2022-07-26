package com.cloudrich.framework.util;
public class CoordinateConverter 
{
	/// <summary>
    /// ��γ�ȶ���ʽת���������ھ���ת��
    /// </summary>
    private double[] m_aPara = new double[4];
    /// <summary>
    /// ��γ�ȶ���ʽת�������û�γ��ת��
    /// </summary>
    private double[] m_bPara = new double[4];
    
    public double m_X; //ת��������ֵ��������꣩����Ӧ��ͼ�е������y
    public double m_Y; //ת��������ֵ��������꣩,��Ӧ��ͼ�еĺ����x
    
    private double m_xOffset = 0;
    private double m_yOffset = 5000000;//yƫ�Ƴ���500����
    
    public CoordinateConverter(){
    	m_aPara[0] = -0.95845733039298400000;
    	m_aPara[1] = -0.02379193119772570000;
    	m_aPara[2] = 0.00855885627196043000;
    	m_aPara[3] = 0.00022736313874624900;
    	m_bPara[0] = -5.19200841196039000000;
    	m_bPara[1] = -0.13556159294785800000;
    	m_bPara[2] = 0.04777583627472910000;
    	m_bPara[3] = 0.00120928062735496000;
    }
    
    ///b--γ�ȣ�l--����
    public boolean WGS84toBJ54(double b,double l)
    {
    	double m_aAxis = 6378245.0;
    	double m_bAxis = 6356863.01877305;
    	double m_dbMidLongitude = 108.0;
    	//��γ�ȶ���ʽת��
    	double a1 = m_aPara[0],a2 = m_aPara[1],a3 = m_aPara[2],a4 = m_aPara[3];
        double b1 = m_bPara[0],b2 = m_bPara[1],b3 = m_bPara[2],b4 = m_bPara[3];
    	try
        {    		
    		m_X = b + a1 + a2 * b + a3 * l + a4 * l * b;
            m_Y = l + b1 + b2 * b + b3 * l + b4 * l *b;
        }
        catch (Exception ex)
        {
            return false;
        }
    	//end
    	
    	return true;    	
    }    

    public static void main(String[] args) {
    	CoordinateConverter c 	= new CoordinateConverter();
    	c.WGS84toBJ54(18.635703, 109.706828);
    	System.out.println(c.m_X);
    	System.out.println(c.m_Y);
    	
	}
}
