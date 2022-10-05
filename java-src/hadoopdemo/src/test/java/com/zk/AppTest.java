package com.zk;


import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.IOException;

/**
 * Unit test for simple App.
 */
public class AppTest {

    Configuration configuration = null;
    FileSystem fs = null;

    @BeforeEach
    void setUp() throws IOException {

        configuration = new Configuration(true);
        fs = FileSystem.get(configuration);
    }

    @Test
    public void mkdir() throws IOException {
        Path path = new Path("/zk");
        if (!fs.exists(path)) {
            fs.delete(path, true);
        }
        fs.mkdirs(path);
    }
}
