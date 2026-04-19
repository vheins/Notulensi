allprojects {
    repositories {
        google()
        mavenCentral()
    }
}

val newBuildDir: Directory =
    rootProject.layout.buildDirectory
        .dir("../../build")
        .get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}

subprojects {
    project.evaluationDependsOn(":app")
}

subprojects {
    val project = this
    plugins.forEach { plugin ->
        if (plugin is com.android.build.gradle.LibraryPlugin) {
            val extension = project.extensions.getByName("android") as com.android.build.gradle.LibraryExtension
            extension.namespace = "com.vheins.notulensi.patch." + project.name.replace("-", "_")
        }
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
