public class Lambda {
    public static void main(String... args) {
        final String str = Stream.of("h","e","l","l","o"," ","l","a","m","b","d","a")
                .reduce((s, s2) -> s + s2) // (1)
                .orElse("");

        System.out.println(str);

    }
}