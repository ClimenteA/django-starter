from django.urls import path, include
from django.contrib import admin
from django.shortcuts import render
from django.http import HttpResponse
from django.urls import reverse
from django.contrib.sitemaps import Sitemap
from django.contrib.sitemaps.views import sitemap


def landing(request):
    return render(request, "landing.html")

def legal(request):
    return render(request, "legal.html")

def robots_txt(request):
    content = "User-agent: *\nDisallow:"
    return HttpResponse(content, content_type="text/plain")


class MainViewSitemap(Sitemap):
    changefreq = "monthly"
    priority = 1

    def items(self):
        return ["landing"]

    def location(self, item):
        return reverse(item)

sitemaps = {
    "static": MainViewSitemap,
}


urlpatterns = [
    path("", landing, name="landing"),
    path("legal/", legal, name="legal"),
    path("admin/", admin.site.urls),
    path("robots.txt", robots_txt),
    path(
        "sitemap.xml",
        sitemap,
        {"sitemaps": sitemaps},
        name="django.contrib.sitemaps.views.sitemap",
    ),
    path("__reload__/", include("django_browser_reload.urls")),
]
