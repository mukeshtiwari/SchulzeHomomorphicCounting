HelloWorld.class : schulze/HelloWorld.java 
	javac -cp ".:jarfiles/unicrypt-2.3.jar:jarfiles/jnagmp-2.0.0.jar:jarfiles/jna-4.5.0.jar"  schulze/HelloWorld.java 

HelloWorld : schulze/HelloWorld.class
	java -cp ".:jarfiles/unicrypt-2.3.jar:jarfiles/jnagmp-2.0.0.jar:jarfiles/jna-4.5.0.jar" schulze.HelloWorld

jarfile : schulze/HelloWorld.class
	jar cvf schulze.jar schulze/HelloWorld.class 

clean:
	rm -rf  schulze/*.class schulze/*.jar schulze.jar 2>/dev/null || true
