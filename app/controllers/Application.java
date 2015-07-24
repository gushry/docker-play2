package controllers;

import play.mvc.Controller;
import play.mvc.Result;

public class Application extends Controller {
    
    public static Result index() {
        String env = com.typesafe.config.ConfigFactory.load().getString("my.env");
        return ok(views.html.index.render("Hello Play Framework " + env));
    }
    
}
