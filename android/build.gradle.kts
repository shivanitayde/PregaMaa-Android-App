allprojects {
    repositories {
        google()
        mavenCentral()
    }
    dependencies {
        
    }
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
    // Only relocate build directories and add evaluation dependency for projects
    // that are inside the root project's directory. This avoids cross-drive
    // buildDir issues with plugins located in the global pub cache.
    val rootDirPath = rootProject.projectDir.absolutePath
    if (project.projectDir.absolutePath.startsWith(rootDirPath)) {
        val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
        project.layout.buildDirectory.value(newSubprojectBuildDir)
        project.evaluationDependsOn(":app")
    }
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
