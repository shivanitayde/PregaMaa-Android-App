allprojects {
    repositories {
        google()
        mavenCentral()
    }
<<<<<<< HEAD
    dependencies {
        
    }
=======
>>>>>>> f3fd9aa05832e60897b85b5cf4e7954fbe9dc81a
}

val newBuildDir: Directory = rootProject.layout.buildDirectory.dir("../../build").get()
rootProject.layout.buildDirectory.value(newBuildDir)

subprojects {
<<<<<<< HEAD
    // Only relocate build directories and add evaluation dependency for projects
    // that are inside the root project's directory. This avoids cross-drive
    // buildDir issues with plugins located in the global pub cache.
    val rootDirPath = rootProject.projectDir.absolutePath
    if (project.projectDir.absolutePath.startsWith(rootDirPath)) {
        val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
        project.layout.buildDirectory.value(newSubprojectBuildDir)
        project.evaluationDependsOn(":app")
    }
=======
    val newSubprojectBuildDir: Directory = newBuildDir.dir(project.name)
    project.layout.buildDirectory.value(newSubprojectBuildDir)
}
subprojects {
    project.evaluationDependsOn(":app")
>>>>>>> f3fd9aa05832e60897b85b5cf4e7954fbe9dc81a
}

tasks.register<Delete>("clean") {
    delete(rootProject.layout.buildDirectory)
}
