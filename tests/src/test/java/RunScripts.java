import com.zaxxer.hikari.HikariDataSource;
import org.junit.After;
import org.junit.Before;
import org.junit.Test;
import za.co.imqs.testing.scripting.RemoteScripts;
import za.co.imqs.testing.scripting.ScriptingConfig;

import javax.sql.DataSource;
import java.io.File;
import java.io.FileNotFoundException;
import java.nio.file.Files;
import java.nio.file.Path;
import java.nio.file.Paths;
import java.util.Arrays;
import java.util.LinkedList;
import java.util.List;

/**
 * (c) 2016 IMQS Software
 * <p>
 * User: BradleyMe
 * Date: 22-Aug-17.
 */
public class RunScripts {

    private static final String DRIVER = "com.microsoft.sqlserver.jdbc.SQLServerDriver";
    private static final String JDBC_URL = "jdbc:sqlserver://localhost:1433;instanceName=SQLEXPRESS;DatabaseName=assettesting";
    private static final String USERNAME = "sa";
    private static final String PASSWORD = "1mq5p@55w0rd";

    private static final String USER_DIR = System.getProperty("user.dir") + "\\..\\scripts\\v6\\";
    private static final List<String> SCRIPT_FILES = Arrays.asList(
            "01-asset-fin-forms.sql",
            "02-asset-register.sql",
            "03-asset-wip.sql",
            "04-asset-policy.sql",
            "05-asset-scoa.sql",
            "06-asset-admin.sql",

            "prime/01-asset-fin-forms.sql",
            "prime/02-asset-register.sql",
            "prime/03-asset-wip.sql",
            "prime/04-asset-policy.sql",
            "prime/06-asset-admin.sql",

            "prime/10-SCOAJournal.csv",
            "prime/11-SCOAClassification.csv",
            "prime/12-SCOADepreciationStatus.csv",
            "prime/14-AssetRegisterIconFin2017.csv",

            "prime/20-AssetFinFormBatch.csv",
            "prime/21-AssetFinFormInput.csv",
            "prime/22-AssetFinFormRef.csv",

            "stored-procs/01-delete-stored-procs.sql",
            "stored-procs/02-create-scoa-batch.sql",
            "stored-procs/03-export-samras-scoa-journal-rollup.sql",
            "stored-procs/04-export-samras-scoa-master-data-for-batch.sql",
            "stored-procs/05-export-scoa-journal-no-rollup.sql",
            "stored-procs/06-export-scoa-journal-rollup.sql",
            "stored-procs/07-export-solar-scoa-journal-rollup.sql",
            "stored-procs/08-export-venus-scoa-journal-rollup.sql",
            "stored-procs/09-update-scoa-journal-scoa-file-name.sql",

            "views/01-asset-register-view.sql",
            "views/02-input-forms.sql"
    );


    private DataSource ds;

    @Before
    public void init() {
        final HikariDataSource ds = new HikariDataSource();

        ds.setDriverClassName(DRIVER);
        ds.setJdbcUrl(JDBC_URL);
        ds.setUsername(USERNAME);
        ds.setPassword(PASSWORD);

        this.ds = ds;
    }

    @Test
    public void run() throws Exception {
        final List<File> scriptFiles = new LinkedList<>();
        for (String f : SCRIPT_FILES) {
            final Path p = Paths.get(USER_DIR, f);
            if (!Files.exists(p))
                throw new FileNotFoundException(f + " does not exist or cannot be found");
            scriptFiles.add(p.toFile());
        }

        final RemoteScripts remoteScripts = new RemoteScripts();
        remoteScripts.createAndPrimeTheV6TestDb(ds, scriptFiles);
    }
}
