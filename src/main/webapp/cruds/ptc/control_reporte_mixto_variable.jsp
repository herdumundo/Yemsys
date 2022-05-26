<%@page import="clases.controles"%>
<%@page import="java.text.SimpleDateFormat"%>
<%@page import="java.sql.Connection"%>
<%@page contentType="text/html" pageEncoding="UTF-8"%>
<%@page import="java.io.*"%>
<%@page import="java.util.*"%>
<%@page import="net.sf.jasperreports.engine.*"%>
<%@page import="net.sf.jasperreports.view.JasperViewer"%>
<%@include  file="../../chequearsesion.jsp" %>
<%         
    clases.controles.connectarBD();  
    Connection con = clases.controles.connect;    
    String clasificadora        =   (String) sesionOk.getAttribute("clasificadora");
    String fecha_desde          =   request.getParameter("calendario_reporte_carros_mixto");
    String fecha_hasta          =   request.getParameter("calendario_reporte_carros_mixto_hasta");
    String estado_liberacion    =   request.getParameter("cbox_estado");
    String cod_carrito          =   request.getParameter("cod_carrito");
    String filtro_calendario    =   request.getParameter("filtro_calendario");
    String filtro_aviario       =   request.getParameter("filtro_aviario");
    String  [] array_tipo_huevo =   request.getParameterValues("tipo_huevo");
    String  [] array_aviarios   =   request.getParameterValues("aviarios");
    String cch                  =   "";
    String tipo_huevo           =   "";
    String aviarios             =   "";
    if(clasificadora.equals("A"))
    {
        cch="CCHA";
    }
    else if(clasificadora.equals("B"))
    {
        cch="CCHB";
    }
    else if(clasificadora.equals("H"))
    {
        cch="CCHH";
    }
    else if(clasificadora.equals("O"))
    {
        cch="LAVADO";
    }
 
    for(int i=0; i<array_tipo_huevo.length; i++)   
    {
        if (array_tipo_huevo.length>1)
        {
            if(i==0)
            {
                tipo_huevo=array_tipo_huevo[i];  
            }
            else 
            {
                tipo_huevo=tipo_huevo+ ","+array_tipo_huevo[i];  
            }
        }
        else if (array_tipo_huevo.length==1)
        {
            tipo_huevo=array_tipo_huevo[i];  
        }
    }
 
    if (filtro_aviario.equals("SI"))
    {
        for(int i=0; i<array_aviarios.length; i++)   
        {
            if (array_aviarios.length>1)
            {
                if(i==0)
                {
                    aviarios=array_aviarios[i];  
                }
                else 
                {
                    aviarios=aviarios+ ","+array_aviarios[i];  
                }
            }
            else if (array_aviarios.length==1)
            {
                aviarios=array_aviarios[i];  
            }
        }
     }          
          SimpleDateFormat sdformat = new SimpleDateFormat("dd/MM/yyyy");
      Date fecha_puestav1 = sdformat.parse(fecha_desde);
      Date fechav2 = sdformat.parse("26/04/2021");
     
     if (fecha_puestav1.before(fechav2)) {
            File reportfile = new File (application.getRealPath("reportes/ptc/Rev01/reporte_lotes_mixtos_variables.jasper"));
        Map<String,Object> parameter = new HashMap<String,Object>();
     parameter.put("fecha",new String(fecha_desde));
            parameter.put("fecha_hasta",new String(fecha_hasta));
            parameter.put("clasificadora",new String(clasificadora));
            parameter.put("status",new String(estado_liberacion));
            parameter.put("filtro_calendario",new Integer(filtro_calendario));
            parameter.put("carro",new String(cod_carrito));
            parameter.put("filtro_aviario", filtro_aviario ); 
            parameter.put("aviarios", aviarios );    
            parameter.put("tipo_huevo", tipo_huevo );
            parameter.put("estado_liberacion", estado_liberacion );
            
         byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
        response.setContentType("application/pdf");
        response.setContentLength(bytes.length);
            response.setHeader("Content-Disposition",  "inline; filename=M-FOR-CYO-42_"+fecha_desde+"_"+cch+".pdf");
        ServletOutputStream outputstream = response.getOutputStream();
        outputstream.write(bytes,0,bytes.length);
        outputstream.flush();
        outputstream.close(); 
        }
     
     else {
         
              
            File reportfile = new File (application.getRealPath("reportes/ptc/reporte_lotes_mixtos_variables.jasper"));
            Map<String,Object> parameter = new HashMap<String,Object>();
            parameter.put("fecha",new String(fecha_desde));
            parameter.put("fecha_hasta",new String(fecha_hasta));
            parameter.put("clasificadora",new String(clasificadora));
            parameter.put("status",new String(estado_liberacion));
            parameter.put("filtro_calendario",new Integer(filtro_calendario));
            parameter.put("carro",new String(cod_carrito));
            parameter.put("filtro_aviario", filtro_aviario ); 
            parameter.put("aviarios", aviarios );    
            parameter.put("tipo_huevo", tipo_huevo );
            parameter.put("estado_liberacion", estado_liberacion );
            
            byte [] bytes = JasperRunManager.runReportToPdf(reportfile.getPath(), parameter, con);
            response.setContentType("application/pdf");
            response.setHeader("Content-Disposition",  "inline; filename=M-FOR-CYO-42_"+fecha_desde+"_"+cch+".pdf");
            response.setContentLength(bytes.length);
            ServletOutputStream outputstream = response.getOutputStream();
            outputstream.write(bytes,0,bytes.length);
            outputstream.flush();
            outputstream.close();
         
     }
     con.close();
     controles.DesconnectarBD();
        %>