<%@ Import Namespace="System" %>
<%@ Page Language="c#"%>

<script runat="server">
    public string GetMachineVariables()
    {
        IDictionary variables = Environment.GetEnvironmentVariables(EnvironmentVariableTarget.Machine);
        return FormatEnvironmentVariables(variables);
    }

    public string GetProcessVariables()
    {
        IDictionary variables = Environment.GetEnvironmentVariables(EnvironmentVariableTarget.Process);
        return FormatEnvironmentVariables(variables);
    }

    public string GetUserVariables()
    {
        IDictionary variables = Environment.GetEnvironmentVariables(EnvironmentVariableTarget.User);
        return FormatEnvironmentVariables(variables);
    }

    public string FormatEnvironmentVariables(IDictionary variables)
    {
        var sb = new StringBuilder();
        sb.AppendLine("<ul>");
        var keys = new ArrayList(variables.Keys);
	    keys.Sort();
	    foreach (var key in keys)        
        {
            sb.Append(string.Format("<li><b>{0}</b>: {1}</li>", key, variables[key]));
        }
        sb.AppendLine("</ul>");
        return sb.ToString();
    }
</script>

<% string pageVariable = "world"; %>
<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.0 Transitional//EN"
    "http://www.w3.org/TR/xhtml1/DTD/xhtml1-transitional.dtd">
<html xmlns="http://www.w3.org/1999/xhtml" xml:lang="en" lang="en">
<head>
<meta http-equiv="Content-Type" content="text/html; charset=windows-1252" />
<title>ASP.NET inline</title>
</head>
<body>
    <p>
        <h2>Machine-level Environment Variables</h2>
            <% =GetMachineVariables() %>
    </p>
    <hr/>
    <p>
        <h2>Process-level Environment Variables</h2>
            <% =GetProcessVariables() %>
    </p>
    <hr/>
    <p>
        <h2>User-level Environment Variables</h2>
            <% =GetUserVariables() %>
    </p>        
</body>
</html>