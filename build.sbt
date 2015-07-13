import play.Project._
import com.typesafe.sbt.packager.docker._

name := """docker-play2"""

version := "1.0-SNAPSHOT"

libraryDependencies ++= Seq(
  "org.webjars" %% "webjars-play" % "2.2.2", 
  "org.webjars" % "bootstrap" % "2.3.1")

playJavaSettings

enablePlugins(DockerPlugin)

packageName in Docker := "gushry/docker-play2"
dockerBaseImage := "gushry/play2"
maintainer := "gushry"

dockerExposedPorts := Seq(9000)
