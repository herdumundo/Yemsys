<%@include  file="../cruds/conexion.jsp" %> 
<%
    String option_camiones = "";
    String option_choferes = "";
    String fecha_hora = "";
    try {
        ResultSet rs_GM, rs_GM2, rs_hora;
        Statement st, st2, st3;
        st = connection.createStatement();
        rs_GM = st.executeQuery("  select code,name from maehara.dbo.[@CAMIONES]  ");

        st2 = connection.createStatement();
        rs_GM2 = st2.executeQuery("   select code,name from maehara.dbo.[@CHOFERES] with(nolock) order by 2 ");

        
        st3 = connection.createStatement();
        rs_hora = st3.executeQuery(" SELECT  convert(varchar,getdate(),111) as fecha,REPLACE(CONVERT(VARCHAR(10),  convert(varchar,getdate(),103), 5),'/','') ");

        
        while (rs_GM.next()) {
            option_camiones = option_camiones
                    + "<option   value='" + rs_GM.getString(1) + "_" + rs_GM.getString(2) + "'> " + rs_GM.getString(1) + "- " + rs_GM.getString(2) + " </option> ";
        }
        rs_GM.close();

        while (rs_GM2.next()) {
            option_choferes = option_choferes
                    + "<option   value='" + rs_GM2.getString(1) + "_" + rs_GM2.getString(2) + "'> " + rs_GM2.getString(2) + " </option> ";
        }
        rs_GM2.close();

        
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

