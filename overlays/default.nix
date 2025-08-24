final: prev: {
  hello-custom = prev.hello.override { pname = "hello-custom"; };
}
