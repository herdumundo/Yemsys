<%@include  file="../../cruds/conexion.jsp" %> 
<%
    String option_disposicion = "";
    String option_motivo_retencion = "";
    String fecha_hora = "";

     try {
        ResultSet rs_GMdisposicion, rs_GM2motivo_retencion,rs_hora;
        Statement stdisposicion, st2motivo_retencion,st3;
        
        stdisposicion = connection.createStatement();
        rs_GMdisposicion = stdisposicion.executeQuery(" select * from motivo_retencion  with (nolock) where tipo='disposicion'  ");
        
         st3 = connection.createStatement();
        rs_hora = st3.executeQuery(" SELECT  convert(varchar,getdate(),111) as fecha,REPLACE(CONVERT(VARCHAR(10),  convert(varchar,getdate(),103), 5),'/','') ");

       
        
        
        while (rs_GMdisposicion.next()) {
            option_disposicion = option_disposicion
                    + "<option   value='" + rs_GMdisposicion.getString("id") +  "'> " + rs_GMdisposicion.getString("descripcion") + " </option> ";
        }
        rs_GMdisposicion.close();
 
        
        
        st2motivo_retencion = connection.createStatement();
        rs_GM2motivo_retencion = st2motivo_retencion.executeQuery(" select * from motivo_retencion with (nolock) where tipo='motivo'  ");
        
        while (rs_GM2motivo_retencion.next()) {
            option_motivo_retencion = option_motivo_retencion
                    + "<option   value='" + rs_GM2motivo_retencion.getString("descripcion") +  "'> " + rs_GM2motivo_retencion.getString("descripcion") + " </option> ";
        }
        rs_GM2motivo_retencion.close();
 
        
           if (rs_hora.next()) {
            fecha_hora = rs_hora.getString(1);
        }
        rs_hora.close();

        
    } catch (Exception e) {
        String a = e.toString();
    } finally {
        connection.close();
    }
%> 

