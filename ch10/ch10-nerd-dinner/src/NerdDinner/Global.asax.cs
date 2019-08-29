using AutoMapper;
using System;
using System.Reflection;
using System.Web.Http;
using System.Web.Mvc;
using System.Web.Optimization;
using System.Web.Routing;
using models = NerdDinner.Models;
using entities = NerdDinner.Core.Entities;
using NerdDinner.ValueResolvers;

namespace NerdDinner
{
    // Note: For instructions on enabling IIS6 or IIS7 classic mode, 
    // visit http://go.microsoft.com/?LinkId=9394801

    public class MvcApplication : System.Web.HttpApplication
    {
        protected void Application_Start()
        {
            AreaRegistration.RegisterAllAreas();

            WebApiConfig.Register(GlobalConfiguration.Configuration);
            FilterConfig.RegisterGlobalFilters(GlobalFilters.Filters);
            RouteConfig.RegisterRoutes(RouteTable.Routes);
            BundleConfig.RegisterBundles(BundleTable.Bundles);
            AuthConfig.RegisterAuth();

            ModelBinderProviders.BinderProviders.Add(new EFModelBinderProvider());

            Version version = Assembly.GetExecutingAssembly().GetName().Version;
            Application["Version"] = string.Format("{0}.{1}", version.Major, version.Minor);

            Mapper.Initialize(cfg =>
                cfg.CreateMap<models.Dinner, entities.Dinner>()
                   .ForMember(dest => dest.Coordinates, opt => opt.ResolveUsing<CoordinatesValueResolver>()));
        }
    }
}