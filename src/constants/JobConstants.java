/*
 * To change this template, choose Tools | Templates
 * and open the template in the editor.
 */
package constants;

/**
 *
 * @author Itzik
 */
public class JobConstants {

    public static final boolean enableJobs = true;
    public static final int jobOrder = 7;

    public enum LoginJob {//disabled for beta

        Resistance(0, JobFlag.DISABLED),
        Adventurer(1, JobFlag.ENABLED),
        Cygnus(2, JobFlag.DISABLED),
        Aran(3, JobFlag.DISABLED),
        Evan(4, JobFlag.DISABLED),
        Mercedes(5, JobFlag.DISABLED),
        Demon(6, JobFlag.DISABLED),
        Phantom(7, JobFlag.DISABLED),
        DualBlade(8, JobFlag.DISABLED),
        Mihile(9, JobFlag.DISABLED),
        Luminous(10, JobFlag.DISABLED),
        Kaiser(11, JobFlag.DISABLED),
        AngelicBuster(12, JobFlag.DISABLED),
        Cannoneer(13, JobFlag.DISABLED),
        Xenon(14, JobFlag.DISABLED),
        Zero(15, JobFlag.DISABLED),
        Shade(16, JobFlag.DISABLED),
        Jett(17, JobFlag.DISABLED),
        Hayato(18, JobFlag.DISABLED),
        Kanna(19, JobFlag.DISABLED),
        Beastamer(20, JobFlag.DISABLED),
    	PinkBean(21, JobFlag.DISABLED),
    	Kinesis(22, JobFlag.DISABLED);
    	
        private final int jobType, flag;

        private LoginJob(int jobType, JobFlag flag) {
            this.jobType = jobType;
            this.flag = flag.getFlag();
        }

        public int getJobType() {
            return jobType;
        }

        public int getFlag() {
            return flag;
        }

        public enum JobFlag {

            DISABLED(0),
            ENABLED(1);
            private final int flag;

            private JobFlag(int flag) {
                this.flag = flag;
            }

            public int getFlag() {
                return flag;
            }
        }
    }
}
