package com.zk;


import org.apache.hadoop.conf.Configuration;
import org.apache.hadoop.fs.FSDataOutputStream;
import org.apache.hadoop.fs.FileSystem;
import org.apache.hadoop.fs.Path;
import org.apache.hadoop.io.IOUtils;
import org.junit.jupiter.api.BeforeEach;
import org.junit.jupiter.api.Test;

import java.io.*;

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


    @Test
    void upload() throws IOException {
        BufferedInputStream bufferedInputStream = new BufferedInputStream(new FileInputStream(new File(
                "./data/words.txt")));
           Path path = new Path("/zk/words2.txt");
           FSDataOutputStream fsDataOutputStream = fs.create(path);
           IOUtils.copyBytes(bufferedInputStream,fsDataOutputStream,configuration, true);
    }

    @Test
    void read() {
        Path path = new Path("/zk/words.txt");

    }
}
