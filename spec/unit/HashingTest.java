// Class for verifyinng hash functions agains Java's implementation.
//
// It's intentionally free of any build environment baggage. To run:
//
// (export CLASSPATH=/usr/local/...YADA-YADA.../kafka-clients-0.8.X.X.jar:. ; javac HashingTest.java && java HashingTest)

import org.apache.kafka.common.utils.Utils;

public class HashingTest {
  public final static int PARTITIONS = 50;
  public final static String[] KEYS = {
    "foobar", "baz", "rm-foo", "yello", "poseidon says hi",
    // Unicode.
    "Здравствуй, мир!", "你好世界", "こんにちは世界",
    // Corner cases.
    "", " ", "  ", "   ", "    "
  };
  
  public static void main(String[] args) throws Exception {
    if (args.length > 0) throw new RuntimeException("No args allowed");
    for (String k : KEYS) {
      int part = Utils.abs(Utils.murmur2(k.getBytes("UTF-8"))) % PARTITIONS;
      System.out.println("'" + k + "' => " + part + " , ");
    }
  }
}
