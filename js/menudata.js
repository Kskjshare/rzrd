var menudata = {
    'my': {
        'text': '基础信息',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'welcome': {
                'text': '基础信息管理',
                'powerid': '1',
                'children': {
                    'head': {
                        'text': '首页',
                        'url': '/suggest/homepage.jsp'
                    },
                    'representative': {
                        'text': '代表管理',
                        'url': '/delegate/list.jsp',
                        'powerid': '2',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增代表',
                            },
                            'edit': {
                                'text': '编辑代表',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'import': {
                                'text': '导入',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
     
                    },
                    'office': {
                        'text': '机关用户管理',
                        'url': '/authorityuser/officelist.jsp',
                        'powerid': '2',
             
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增机关用户',
                            },
                            'edit': {
                                'text': '编辑用户',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'import': {
                                'text': '导入',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                        
                        
                    },
                    'delegation': {
                        'text': '代表团管理',
                        'url': '/delegation/list.jsp',
                        'powerid': '3',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增代表团',
                            },
                            'edit': {
                                'text': '编辑代表团',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'company': {
                        'text': '单位管理',
                        'url': '/company/list.jsp',
                        'powerid': '4',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增单位',
                            },
                            'edit': {
                                'text': '编辑单位',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    
                    'town': {
                      'text': '乡镇人大代表管理',
                      'url': '/contactstation/towndelegate/list.jsp',
                      'powerid': '95',
                    },
                    
                    'companyuser': {
                        'text': '单位联系人',
                        'powerid': '5',
                        'url': '/company/companyuser/list.jsp',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'append': {
                                'text': '新增单位',
                            },
                            'edit': {
                                'text': '编辑单位',
                            },
                            'delete': {
                                'text': '删除',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'zhuanweihui': {
                        'text': '专委会管理',
                        'url': '/committee/list.jsp',
                        'powerid': '225',
                    },
                    'xiaozuguanli': {
                        'text': '考核小组管理',
                        'url': '/delegation/group/list.jsp',
                        'powerid': '269',
                    },
                }
            },
            'recharge': {
                'text': '系统管理',
                'powerid': '6',
                'children': {
                    'staff': {
                        'text': '用户管理',
                        'url': '/staff/list.jsp',
                        'powerid': '7',
                    },
//                    'office': {
//                        'text': '机关用户管理',
//                        'url': '/delegate/officelist.jsp',
//                        'powerid': '',
//                    },
                    'power': {
                        'text': '权限管理',
                        'url': '/staff/powerlist/list.jsp',
                        'powerid': '8',
                    },
                    'group': {
                        'text': '角色管理',
                        'url': '/staff/power/group/list.jsp',
                        'powerid': '9',
                    },
                    'position': {
                        'text': '日志管理',
                        'url': '/staff/position/list.jsp',
                        'powerid': '10',
                    },
//                    'department': {
//                        'text': '用户组',
//                        'url': '/staff/department/list.jsp',
//                        'powerid': '11',
//                    }
                }
            },
            'settings': {
                'text': '设置管理',
                'powerid': '12',
                'children': {
                    'code': {
                        'text': '代码管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '13',
                    },
                    'dictionary': {
                        'text': '字典管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '14',
                    },
                    'meeting': {
                        'text': '会议管理',
                        'url': '/staff/meeting/list.jsp',
                        'powerid': '11',
                    },
                    'timer': {
                        'text': '届次管理',
                        'url': '/setup/session/list.jsp',
                        'powerid': '15',
                    },
                    'companytypeee': {
                        'text': '会议次数管理',
                        'powerid': '0',
                        'url': '/setup_1/companytypeee/list.jsp'
                    },
                    'companytype': {
                        'text': '单位分类管理',
                        'url': '/setup/companytype/list.jsp',
                        'powerid': '0',
                    },
                    'conf': {
                        'text': '配置管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '16',
                    },
                    'statistics': {
                        'text': '统计管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '17',
                    },
                    'reports': {
                        'text': '报表管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '18',
                    },
                    'version': {
                        'text': '版本',
                        'powerid': '19',
                        'url': '/version/list.jsp'
                    },
                    'companytypee': {
                        'text': '审查分类管理',
                        'powerid': '173',
                        'url': '/setup_1/companytypee/list.jsp'
                    },
                    'mingancitype': {
                        'text': '敏感词库管理',
                        'powerid': '184',
                        'url': '/setup_1/mingancitype/list.jsp'
                    },
                    'feedback': {
                        'text': '意见反馈管理',
                        'url': '/meetfeedback/list.jsp',
                        'powerid': '173',
                    },
                    'partytype': {
                        'text': '党派管理',
                        'url': '/setup_1/partytype/list.jsp',
                        'powerid': '190',
                    }
                }
            },
            
            
            'update': {
                'text': '换界代表数据更新',
                'powerid': '12',
                'children': {
                    'code': {
                        'text': '删除代表活动数据',
                        'url': '/updatesessiondelegate/list.jsp',
                    },   
                    'code1': {
                        'text': '删除排行榜数据',
                        'url': '/updatesessiondelegate/rank/list.jsp',
                    }, 
                    
                    'code2': {
                        'text': '刷新排行榜数据',
                        'url': '/updatesessiondelegate/rank/updatelist.jsp',
                    },  
                    
                },
               
            },
            
            
            
            'delegatemembers': {
                'text': '代表团成员分类',
                'powerid': '6',
                'children': {
                    'delegate1': {
                        'text': '小屯镇',
                        'url': '/delegate/listmission.jsp?mission=1027',
                    },
                    'delegate2': {
                        'text': '临汝镇',
                         'url': '/delegate/listmission.jsp?mission=1028',
                    },
                    'delegate3': {
                        'text': '寄料镇',
                         'url': '/delegate/listmission.jsp?mission=1029',
                    },
                    'delegate4': {
                        'text': '温泉镇',
                         'url': '/delegate/listmission.jsp?mission=1030',
                    },
                    'delegate5': {
                        'text': '蟒川镇',
                         'url': '/delegate/listmission.jsp?mission=1031',
                    },
                    'delegate6': {
                        'text': '杨楼镇',
                         'url': '/delegate/listmission.jsp?mission=1032',
                    },
                    'delegate7': {
                        'text': '庙下镇',
                         'url': '/delegate/listmission.jsp?mission=1033',
                    },
                    
                    'delegate8': {
                            'text': '陵头镇',
                             'url': '/delegate/listmission.jsp?mission=1034',
                        },    

                    'delegate9': {
                            'text': '米庙镇',
                             'url': '/delegate/listmission.jsp?mission=1035',
                        },    

                    'delegate10': {
                            'text': '纸坊镇',
                             'url': '/delegate/listmission.jsp?mission=1036',
                        },    

                    'delegate11': {
                            'text': '大峪镇',
                             'url': '/delegate/listmission.jsp?mission=1037',
                 
                        },

                    'delegate12': {
                                   'text': '夏店镇',
                                    'url': '/delegate/listmission.jsp?mission=1038',
                     
                                                   },
                     'delegate13': {
                            'text': '焦村镇',
                             'url': '/delegate/listmission.jsp?mission=1039',
                        },
                     'delegate14': {
                            'text': '骑岭乡',
                             'url': '/delegate/listmission.jsp?mission=1040',
                        },
                     'delegate15': {
                            'text': '王寨乡',
                             'url': '/delegate/listmission.jsp?mission=1041',
                        },
                     'delegate16': {
                                'text': '风穴路街道',
                                 'url': '/delegate/listmission.jsp?mission=1042',
                            },
                     'delegate17': {
                                        'text': '煤山街道',
                                         'url': '/delegate/listmission.jsp?mission=1043',
                                    },
        
                    'delegate18': {
                                        'text': '洗耳河街道',
                                         'url': '/delegate/listmission.jsp?mission=1044',
                                    },
                     'delegate19': {
                                        'text': '钟楼街道',
                                         'url': '/delegate/listmission.jsp?mission=1045',
                                    },
        
                    'delegate20': {
                                        'text': '汝南街道',
                                         'url': '/delegate/listmission.jsp?mission=1046',
                                    },
                   'delegate21': {
                                        'text': '紫云路街道',
                                         'url': '/delegate/listmission.jsp?mission=1047',
                                    }, 
                    'delegate22': {
                                        'text': '市直、驻汝、驻军',
                                         'url': '/delegate/listmission.jsp?mission=1048',
                                    },                 
                }
            },
            'settings': {
                'text': '设置管理',
                'powerid': '12',
                'children': {
                    'code': {
                        'text': '代码管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '13',
                    },
                    'dictionary': {
                        'text': '字典管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '14',
                    },
                    'meeting': {
                        'text': '会议管理',
                        'url': '/staff/meeting/list.jsp',
                        'powerid': '11',
                    },
                    'timer': {
                        'text': '届次管理',
                        'url': '/setup/session/list.jsp',
                        'powerid': '15',
                    },
                    'companytypeee': {
                        'text': '会议次数管理',
                        'powerid': '0',
                        'url': '/setup_1/companytypeee/list.jsp'
                    },
                    'companytype': {
                        'text': '单位分类管理',
                        'url': '/setup/companytype/list.jsp',
                        'powerid': '0',
                    },
                    'conf': {
                        'text': '配置管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '16',
                    },
                    'statistics': {
                        'text': '统计管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '17',
                    },
                    'reports': {
                        'text': '报表管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '18',
                    },
                    'version': {
                        'text': '版本',
                        'powerid': '19',
                        'url': '/version/list.jsp'
                    },
                    'companytypee': {
                        'text': '审查分类管理',
                        'powerid': '173',
                        'url': '/setup_1/companytypee/list.jsp'
                    },
                    'mingancitype': {
                        'text': '敏感词库管理',
                        'powerid': '184',
                        'url': '/setup_1/mingancitype/list.jsp'
                    },
                    'feedback': {
                        'text': '意见反馈管理',
                        'url': '/meetfeedback/list.jsp',
                        'powerid': '173',
                    },
                    'partytype': {
                        'text': '党派管理',
                        'url': '/setup_1/partytype/list.jsp',
                        'powerid': '190',
                    },
                    
                
                }
            }
            
            
            
            
        }
    },
    'top2': {
        'text': '履职管理',
        'powerid': '20',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
//            'consult4': {
//                'text': '“三个满意度”测评',
//                'powerid': '27',
//                'children': {
//                    'monitor4': {
//                        'text': '“一府一委两院”专项工作满意度测评',
//                        'url': '/evaluation/government/list.jsp',
//                        'powerid': '27',
//                    },
//                    'monitor3': {
//                        'text': '代表建议办理情况满意度测评',
//                        'url': '/evaluation/evaluation/list.jsp',
//                        'powerid': '27',
//                    },
//                    'notice1': {
//                        'text': '代表履职满意度测评',
//                        'url': '/evaluation/delegation/list.jsp',
//                    },
//                }
//            },
            //'consult1': {
               // 'text': '通知公告',
               // 'powerid': '21',
               // 'children': {
                //    'notice': {
                 //       'text': '最新资讯',
                   //     'url': '/newinformation/list.jsp',
                   // }
                //}
            //},
            'consult2': {
                'text': '履职等级',
                'powerid': '22',
                'children': {
                }
            },
            'consult3': {
                'text': '履职交流',
                'powerid': '23',
                'children': {
                }
            },
            'consult5': {
                'text': '履职管理',
                'powerid': '400',
                'children': {
                    'notice': {
                        'text': '发起履职活动',
                        'url': '/newinformation/edit_1.jsp',
                        'powerid': '401',
                    },
                    'notice1': {
                        'text': '查看履职活动',
                        'url': '/newinformation/list_1.jsp',
                        'powerid': '402',
                    },
                     'notice2': {
                        'text': '所有履职活动',
                        'url': '/newinformation/list_2.jsp',
                        'powerid': '408',
                    },
                     'notice3': {
                        'text': '履职活动审查',
                        'url': '/newinformation/butreview.jsp',
                        'powerid': '409',
                    },
                }
            },


            'consult4': {
                'text': '“三个满意度”测评',
                'powerid': '27',
                'children': {
//                     'monitor4': {
//                        'text': '“一府一委两院”专项工作满意度测评',
//                        'url': '/evaluation/government/list.jsp',
//                        'powerid': '27',
//                    },
                    'monitor3': {
                        'text': '建议办理情况满意度测评',
                        'url': '/evaluation/satisfaction/list.jsp',
                        'powerid': '27',
                    },
                     'notice1': {
                        'text': '代表履职测评',
                        'url': '/evaluation/delegation/list.jsp',
                    },
                }
            },
//            'consult4': {
//                'text': '办理单位满意度测评',
//                'powerid': '27',
//                'children': {
//                    'notice': {
//                        'text': '我的建议办理满意度测评',
//                        'url': '/evaluation/mysuggest/list.jsp',
//                    },
//                    'monitor2': {
//                        'text': '承办单位测评',
//                        'url': '/evaluation/evaluation/list.jsp',
//                        'powerid': '27',
//                    },
//                    'monitor3': {
//                        'text': '单位办理满意度测表',
//                        'url': '/evaluation/satisfaction/list.jsp',
//                        'powerid': '27',
//                    },
//                    'monitor4': {
//                        'text': '一府一委两院满意度评分',
//                        'url': '/evaluation/government/list.jsp',
//                        'powerid': '27',
//                    }
//                }
//            },
//            'consult5': {
//                'text': '代表履职满意度测评',
//                'powerid': '28',
//                'children': {
//                    'notice1': {
//                        'text': '代表履职满意度测评',
//                        'url': '/evaluation/delegation/list.jsp',
//                    },
//                    'notice': {
//                        'text': '履职详情',
//                        'url': '/lvzhilist/list.jsp',
//                    },
//                    'notice2': {
//                        'text': '评分规则',
//                        'url': '/scoringrules/list.jsp',
//                        'powerid': '29',
//                    }
//                }
//            },
//            'consult6': {
//                'text': '评分规则',
//                'children': {
//                    'notice': {
//                        'text': '评分规则',
//                        'url': '/scoringrules/list.jsp',
//                        'powerid': '29',
//                    }
//                }
//            },

// 'consult6': {
//                'text': '上传履职情况',
////                'powerid': '226',
//                'children': {
//                    
//                    'notice1': {
//                        'text': '出席人代会 ',
////                        'powerid': '231',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=1',
//                    },
//                    'notice2': {
//                        'text': '参加其他会议',
////                        'powerid': '302',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=2',
//                    },
//                    'notice3': {
//                        'text': '参加学习培训',
////                        'powerid': '232',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=3',
//                    },    
//                   'notice4': {
//                        'text': '提出议案，建议、批评和意见',
////                        'powerid': '342',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=4',
//                    },   
//                    'notice5': {
//                        'text': '开展专题调研',
////                        'powerid': '228',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=5',
//                    },
//                    'notice6': {
//                        'text': '参加视察、调研及执法检查',
////                        'powerid': '227',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=6',
//                    },
//                    
//                    'notice7': {
//                        'text': '接待选民',
//                        'powerid': '303',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=7',
//                    },
//                    'notice8': {
//                        'text': '化解矛盾纠纷',
////                        'powerid': '324',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=8',
//                    },
//                    'notice9': {
//                        'text': '扶弱济困',
//                        'powerid': '325',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=9',
//                    },                    
//                    'notice10': {
//                        'text': '办好事、办实事',
////                        'powerid': '326',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=10',
//                    },
//                    'notice11': {
//                        'text': '参加公益慈善事业',
////                        'powerid': '327',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=11',
//                    },  
//                    'notice12': {
//                        'text': '向选民述职',
////                        'powerid': '328',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=12',
//                    },
//                    'notice15': {
//                        'text': '其他',
////                        'powerid': '329',
//                        'url': '/activities/v2/uploadactivity/activitylist.jsp?classify=13',
//                    },
//                }
//            },

            'consult7': {
                'text': '代表活动',
                'powerid': '30',
                'children': {
                    'notice1': {
                        'text': '我的活动',
                        'powerid': '31',
                        'url': '/activities/myactivities/list.jsp',
                    },
                    'notice2': {
                        'text': '发起活动',
                        'powerid': '32',
                        'url': '/activities/start/list.jsp',
                    },
                    'notice3': {
                        'text': '活动报名中',
                        'powerid': '33',
                        'url': '/activities/sign/list.jsp',
                    },
                    'notice4': {
                        'text': '活动进行中',
                        'powerid': '34',
                        'url': '/activities/ongoing/list.jsp',
                    },
                    'notice5': {
                        'text': '活动成果总结',
                        'powerid': '35',
                        'url': '/activities/summary/list.jsp',
                    },
                    'notice6': {
                        'text': '活动管理',
                        'powerid': '36',
                        'url': '/activities/admin/list.jsp',
                    },
                    
                    'notice7': {
                        'text': '代表上传履职活动',
//                        'powerid': '36',
                        'url': '/activities/uploadactivities/list.jsp',
                    }
                }
            },
            'consult8': {
                'text': '履职活动',
                'powerid': '226',
                'children': {
                    
                    'notice1': {
                        'text': '出席人代会 ',
                        'powerid': '231',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=1',
                    },
                    'notice2': {
                        'text': '参加其他会议',
                        'powerid': '302',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=2',
                    },
                    'notice3': {
                        'text': '参加学习培训',
                        'powerid': '232',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=3',
                    },    
                   'notice4': {
                        'text': '提出议案，建议、批评和意见',
                        'powerid': '342',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=4',
                    },   
                    'notice5': {
                        'text': '开展专题调研',
                        'powerid': '228',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=5',
                    },
                    'notice6': {
                        'text': '参加视察、调研及执法检查',
                        'powerid': '227',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=6',
                    },
                    
                    'notice7': {
                        'text': '接待选民',
                        'powerid': '303',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=7',
                    },
                    'notice8': {
                        'text': '化解矛盾纠纷',
                        'powerid': '324',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=8',
                    },
                    'notice9': {
                        'text': '扶弱济困',
                        'powerid': '325',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=9',
                    },                    
                    'notice10': {
                        'text': '办好事、办实事',
                        'powerid': '326',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=10',
                    },
                    'notice11': {
                        'text': '参加公益慈善事业',
                        'powerid': '327',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=11',
                    },  
                    'notice12': {
                        'text': '向选民述职',
                        'powerid': '328',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=12',
                    },
                    'notice15': {
                        'text': '其他',
                        'powerid': '329',
                        'url': '/activities/v2/admin/activitylist.jsp?classify=13',
                    },
                    
                    
                    
//                    'notice1': {
//                        'text': '代表视察活动',
//                        'powerid': '227',
////                        'url': '/activities/v2/admin/list.jsp?classify=1',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=1',
//                    },
//                    'notice2': {
//                        'text': '专题调研活动',
//                        'powerid': '228',
////                        'url': '/activities/v2/admin/list.jsp?classify=2',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=2',
//                    },
//                    'notice3': {
//                        'text': '代表调研活动',
//                        'powerid': '229',
////                        'url': '/activities/v2/admin/list.jsp?classify=3',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=3',
//                    },
//                    'notice4': {
//                        'text': '执法检查活动',
//                        'powerid': '230',
////                        'url': '/activities/v2/admin/list.jsp?classify=4',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=4',
//                    },
//                     'notice5': {
//                        'text': '学习培训活动',
//                        'powerid': '232',
////                        'url': '/activities/v2/admin/list.jsp?classify=5',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=5',
//                    },
//                    'notice6': {
//                        'text': '提出议案建议活动',
//                        'powerid': '342',
////                        'url': '/activities/v2/admin/list.jsp?classify=5',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=6',
//                    },
//                   'notice7': {
//                        'text': '化解矛盾纠纷',
//                        'powerid': '324',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=10',
//                    },
//                    'notice8': {
//                        'text': '扶弱济困',
//                        'powerid': '325',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=11',
//                    },                    
//                    'notice9': {
//                        'text': '办好事、办实事',
//                        'powerid': '326',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=12',
//                    },
//                    'notice10': {
//                        'text': '参加公益慈善事业',
//                        'powerid': '327',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=13',
//                    },  
//                    'notice13': {
//                        'text': '其他活动',
//                        'powerid': '329',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=15',
//                    },
//                    
                    
//                    'notice6': {
//                        'text': '代表培训',
//                        'powerid': '232',
////                        'url': '/activities/v2/admin/list.jsp?classify=6',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=6',
//                    },
//                    'notice8': {
//                        'text': '参加其他会议',
//                        'powerid': '302',
//                        //'url': '/activities/contactTheMasses/list.jsp?classify=8',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=8',
//                    },
//                    'notice9': {
//                        'text': '接待选民活动',
//                        'powerid': '303',
////                        'url': '/activities/contactMassActivityReview/list.jsp?classify=8',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=9',
//                    },
//                    'notice10': {
//                        'text': '化解矛盾纠纷',
//                        'powerid': '324',
////                        'url': '/activities/contactMassActivityReview/list.jsp?classify=8',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=10',
//                    },
//                    'notice11': {
//                        'text': '扶弱济困活动',
//                        'powerid': '325',
////                        'url': '/activities/contactMassActivityReview/list.jsp?classify=8',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=11',
//                    },
//                    'notice12': {
//                        'text': '办好事、办实事',
//                        'powerid': '326',
////                        'url': '/activities/contactMassActivityReview/list.jsp?classify=8',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=12',
//                    },
//                    'notice13': {
//                        'text': '参加公益慈善事业',
//                        'powerid': '327',
////                        'url': '/activities/contactMassActivityReview/list.jsp?classify=8',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=13',
//                    },
//                    'notice14': {
//                        'text': '向选民述职活动',
//                        'powerid': '328',
////                        'url': '/activities/contactMassActivityReview/list.jsp?classify=8',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=14',
//                    },
//                    'notice15': {
//                        'text': '其他活动',
//                        'powerid': '329',
////                        'url': '/activities/contactMassActivityReview/list.jsp?classify=8',
//                        'url': '/activities/v2/admin/activitylist.jsp?classify=15',
//                    },
                    

                }
            },
            'consult9': {
                'text': '履职管理',
                'powerid': '243',
                'children': {
                    'notice1': {
                        'text': '述职管理',
                        'powerid': '244',
                        'url': '/activities/v2/admin/list.jsp?classify=7',
                    },
                    'notice2': {
                        'text': '我的述职',
                        'powerid': '245',
                        'url': '/activities/v2/myactivities/list.jsp?classifytype=2',
                    },
                    'notice3': {
                        'text': '我的履职活动',
                        'powerid': '233',
                        'url': '/activities/v2/myactivities/list.jsp?classifytype=1',
                    },
                }
            },
            'consult10': {
                'text': '履职考核',
                'powerid': '262',
                'children': {
//                    'notice1': {
//                        'text': '考核管理',
//                        'powerid': '263',
//                        'url': '/activities/evaluation/list.jsp',
//                    },
                    'notice2': {
                        'text': '计分说明管理',
                        'powerid': '264',
                        'url': '/activities/evaluation/standard/list.jsp',
                    },
//                    'notice3': {
//                        'text': '考核打分',
//                        'powerid': '265',
//                        'url': '/activities/evaluation/score/list.jsp',
//                    },
//                    'notice4': {
//                        'text': '组织评定',
//                        'powerid': '268',
//                        'url': '/activities/evaluation/evaluate/list.jsp',
//                    },
                     'notice5': {
                        'text': '履职排行榜',
//                        'powerid': '97',
                        'url': '/lvzhilist/ranklist.jsp',
                    },
                }
            },
        }
    },
    'top3': {
        'text': '议案建议',
        'powerid': '37',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'guanli': {
                'text': "议案建议管理",
                'powerid': '38',
                'children': {
                    'suggest': {
                        'text': '建议管理',
                        'url': '/suggest/list.jsp',
                        'powerid': '39',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增建议',
                            },
                            'edit': {
                                'text': '编辑建议',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点建议',
                            },
                            'butexcellent': {
                                'text': '优秀建议',
                            },
                            'butreports': {
                                'text': '报表',
                            }
                        }
                    },
                    'motion': {
                        'text': '议案管理',
                        'url': '/billlist/list.jsp',
                        'powerid': '40',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },
                    
                    
                   'criticism': {
                        'text': '批评管理',
                        'url': '/listManager/criticismList.jsp',
                        'powerid': '362',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },  
                        
                   'opionview': {
                        'text': '意见管理',
                        'url': '/listManager/opinionList.jsp',
                        'powerid': '363',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },  
                    
                        
                   'inquery': {
                        'text': '质询管理',
                        'url': '/listManager/inqueryList.jsp',
                        'powerid': '364',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },
                            'append': {
                                'text': '新增议案',
                            },
                            'edit': {
                                'text': '编辑议案',
                            },
                            'butreview': {
                                'text': '审查',
                            },
                            'butview': {
                                'text': '查看',
                            },
                            'butimportance': {
                                'text': '重点议案',
                            },
                            'butexcellent': {
                                'text': '优秀议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },  
                    
                          
                   'allRecord': {
                        'text': '所有记录',
                        'url': '/listManager/allList.jsp',
                        'powerid': '94',
                        'button': {
                            'quicksearch': {
                                'text': '快速查询',
                            },
                            'supersearch': {
                                'text': '高级查询',
                            },                      
                            'edit': {
                                'text': '编辑议案',
                            },
                            'yareports': {
                                'text': '报表',
                            }
                        }
                    },  
                    
                    
                    
                }
            },
            'motionsubmit': {
                'text': '提交管理',
                'powerid': '41',
                'children': {
                    'motionadd': {
                        'text': '新增记录',
                        'url': '/bill/edit.jsp',
                        'powerid': '42',
                    },
                    'situation': {
                        'text': '信息提交情况',
                        'url': '/bill/see.jsp',
                        'powerid': '43',
                    }
                }
            },
            'review': {
                'text': '议案建议审查',
                'powerid': '44',
                'children': {
                    'situation': {
                        'text': '查看审查情况',
                        'url': '/examine/see.jsp',
                        'powerid': '45',
                        'note': '这是 人代委审查情况',
                    },
                    'processing': {
                        'text': '选联委审查处理',
                        'url': '/examine/handle.jsp',
                        'powerid': '46',
                    },
                    'DBTsituation': {
                        'text': '查看审查情况',
                        'url': '/examine/see_1.jsp',
                        'powerid': '159',
                        'note': '这是 代表团审查情况',
                    },
                    'DBTprocessing': {
                        'text': '代表团审查处理',
                        'url': '/examine/handle_1.jsp',
                        'powerid': '160',
                    },
                    'zfbTsituation': {
                        'text': '查看审查情况',
                        'url': '/examine/see_2.jsp',
                        'powerid': '174',
                        'note': '这是 乡镇政府办审查情况',
                    },
                    'zfbTprocessing': {
                        'text': '乡镇政府办审查处理',
                        'url': '/examine/handle_2.jsp',
                        'powerid': '175',
                    }
                }
            },
            'handle': {
                'text': '议案建议办理',
//                'powerid': '47',
                'children': {
                    'company': {
                        'text': '确定办理单位',
                        'url': '/handle/confirm/see.jsp',
                        'powerid': '48',
                    },
                    'submit': {
                        'text': '议案建议交办',
                        'url': '/handle/assign/look.jsp',
                        'powerid': '49',
                    },
                    'zfbsubmit': {
                        'text': '乡镇政府办办复',
                        'url': '/handle/assign/handle_2.jsp',
                        'powerid': '183',
                    },
                    'reply': {
                        'text': '议案建议办复',
                        'url': '/handle/resume/resume.jsp',
//                        'powerid': '50',
                    },
                    'monitor': {
                        'text': '办理进度监控',
                        'url': '/handle/company.jsp',
                        'powerid': '51',
                    },
                    'report': {
                        'text': '办理总结报告',
                        'url': '/handle/summary/list.jsp',
                        'powerid': '52',
                    }
                }
            },
            'consult1': {
                'text': '我领衔的议案建议',
                'powerid': '53',
                'children': {
                    'report': {
                        'text': '我领衔的列表',
                        'url': '/mysuggest/list.jsp',
                    }
                }
            },
            'consult2': {
                'text': '我联名的议案建议',
                'powerid': '54',
                'children': {
                    'report': {
                        'text': '我联名的列表',
                        'url': '/secsuggest/list.jsp',
                    }
                }
            },
            'consult3': {
                'text': '草稿箱议案建议',
                'powerid': '55',
                'children': {
                    'report': {
                        'text': '草稿箱的议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult4': {
                'text': '不予接收建议',
                'powerid': '56',
                'children': {
                    'report': {
                        'text': '不予接收议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult5': {
                'text': '申请退回建议',
                'powerid': '57',
                'children': {
                    'report': {
                        'text': '申请退回议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult5': {
                'text': '置回议案建议',
                'powerid': '170',
                'children': {
                    'report': {
                        'text': '已置回建议列表',
                        'url': '/drsuggest/list_1.jsp',
                        'powerid': '171',
                    }, 'reqport': {
                        'text': '已置回议案列表',
                        'url': '/drsuggest/list_1_1.jsp',
                        'powerid': '172',
                    }, 'reqport1': {
                        'text': '已置回批评列表',
                        'url': '/drsuggest/criticismList.jsp',
                        'powerid': '365',
                    }, 'reqport2': {
                        'text': '已置回意见列表',
                        'url': '/drsuggest/opionList.jsp',
                        'powerid': '366',
                    }, 'reqport3': {
                        'text': '已置回质询列表',
                        'url': '/drsuggest/inqueryList.jsp',
                        'powerid': '367',
                    },
                }
            },
            'consult6': {
                'text': '申请延期建议',
                'powerid': '58',
                'children': {
                    'report': {
                        'text': '申请延期议案建议列表',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult7': {
                'text': '对口联系专委会建议',
                'powerid': '59',
                'children': {
                    'report': {
                        'text': '对口联系专委会建议',
                        'url': '/drsuggest/list.jsp',
                    }
                }
            },
            'consult100': {
                'text': '建议议案测评管理',
                'powerid': '24',
                'children': {
                    'submit': {
                        'text': '已提交征询意见',
                        'url': '/opinion/see.jsp',
                        'powerid': '25',
                    },
                    'monitor': {
                        'text': '建议议案办理信息',
                        'url': '/opinion/look.jsp',
//'url': '/statistics/lvzhistatistics/list_test.jsp',
                        'powerid': '26',
                    },
                     'monitor1': {
                        'text': '满意率统计',
//                        'url': '/opinion/evaluation/totalRate.jsp',
                        'url': '/opinion/evaluation/totalEvaluationList.jsp',
                        'powerid': '96',
                    },
                    'monitor2': {
                        'text': '待测评建议议案',
                        'url': '/listManager/evaluateList.jsp',
                        'powerid': '94',
                    },
                    'monitor3': {
                        'text': '履职排行榜',
                        'url': '/lvzhilist/ranklist.jsp',
                        'powerid': '98',
                    },
                    
//                    'monitor2': {
//                        'text': '承办单位测评',
//                        'url': '/opinion/evaluation/list.jsp',
//                        'powerid': '24',
//                    },
//                    'monitor3': {
//                        'text': '单位办理满意度测表',
//                        'url': '/opinion/satisfaction/list.jsp',
//                        'powerid': '24',
//                    },
//                    'monitor4': {
//                        'text': '一府一委两院满意度评分',
//                        'url': '/opinion/government/list.jsp',
//                        'powerid': '24',
//                    }
                }
            },
            'statistics': {
                'text': '信息统计分析',
                'powerid': '60',
                'children': {
                    'company': {
                        'text': '议案建议统计',
                        'url': '/statistics/suggest/list.jsp',
                        'powerid': '61',
                    },
                    'submit': {
                        'text': '代表信息统计',
                        'url': '/statistics/delegateinfo/list.jsp',
                        'powerid': '62',
                    },
                    'reply': {
                        'text': '履职统计',
                        'url': '/statistics/lvzhistatistics/list_delegate.jsp',
                        'powerid': '63',
                    },
//                    'monitor': {
//                        'text': '建议办理统计',
//                        'url': '/statistics/proposal.jsp',
//                        'powerid': '64',
//                    }
                }
            },
            'inquire': {
                'text': '信息综合查询',
                'powerid': '65',
                'children': {
                    'reply': {
                        'text': '代表信息',
                        'url': '/query/delegate/list.jsp',
                        'powerid': '68',
                    },
                    'company': {
                        'text': '建议信息',
                        'url': '/query/suggest/list.jsp',
                        'powerid': '66',
                    },
                    'submit': {
                        'text': '议案信息',
                        'url': '/query/billlist/list.jsp',
                        'powerid': '67',
                    },
                    'monitor': {
                        'text': '单位信息',
                        'url': '/query/company/list.jsp',
                        'powerid': '69',
                    }
                }
            },
            
            
            'permission': {
                'text': '测评权限管理',
                'powerid': '95',
                'children': {
                    'reply': {
                        'text': '测评开关设置',
//                        'url': '/staff/permission.jsp',
                         'url': '/activities/evaluation/permission_list.jsp',
                        'powerid': '',
                    }
                    
                }
            },
            
             'meetingsession': {
                'text': '会议届次管理',
                'powerid': '95',
                'children': {
                    'reply': {
                        'text': '会议届次管理',
                         'url': '/suggest/sessionManager/list.jsp',
                        'powerid': '',
                    }
                    
                }
            },
            
            'menutop3':{
                'text': "审查分类管理",
                'powerid': '368',
                'children': {
                    'notice': {
                        'text': '添加分类类别',
                        'powerid': '369',
                        'url': '/bill/tianjiafenlei.jsp',
                    },
                    
                }
            },
        }
    },
    'top4': {
        'text': '学习培训',
        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            
            
            'menutop1': {
                'text': "大数据分析",
//                'powerid': '71',
                'children': {
                    'monitor': {
                       'text': '大数据分析',
                       'url': '/visualdata/training.html',
                    }
                }
            },
            
            'menutop2': {
                'text': "学习课件",
                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '学习课件',
                        'url': '/training/courseware/list.jsp',
                    }
                }
            },
            'menutop3': {
                'text': "专题讲座",
                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '专题讲座',
                        'url': '/training/lecture/list.jsp',
                    }
                }
            },
            'menutop4': {
                'text': "法律法规",
                'powerid': '73',
                'children': {
                    'monitor': {
                        'text': '宪法',
                        'url': '/training/statute/xianfa/list.jsp',
                    },
                    'monitor1': {
                        'text': '国家法律',
                        'url': '/training/statute/guofa/list.jsp',
                    },
                    'monitor2': {
                        'text': '相关法规',
                        'url': '/training/statute/fagui/list.jsp',
                    }
                }
            },
            'menutop5': {
                'text': "履职参考",
                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '履职参考',
                        'url': '/training/reference/list.jsp',
                    }
                }
            },
             'menutop6': {
                'text': "在线学习",
//                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '在线学习',
                        'url': '/training/reference/list.jsp',
                    }
                }
            },
             'menutop7': {
                'text': "知识点管理",
//                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '知识点管理',
                        'url': '/training/reference/list.jsp',
                    }
                }
            },
             'menutop8': {
                'text': "题型管理",
//                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '题型管理',
                        'url': '/training/reference/list.jsp',
                    }
                }
            },
             'menutop9': {
                'text': "题库管理",
//                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '题库管理',
                        'url': '/training/reference/list.jsp',
                    }
                }
            },
             'menutop10': {
                'text': "试题征集信息",
//                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '试题征集信息',
                        'url': '/training/reference/list.jsp',
                    }
                }
            },
            'menutop11': {
                'text': "试卷管理",
//                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '试卷管理',
                        'url': '/training/reference/list.jsp',
                    }
                }
            },
            'menutop12': {
                'text': "考试类别管理",
//                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '考试类别管理',
                        'url': '/training/reference/list.jsp',
                    }
                }
            },
             'menutop13': {
                'text': "成绩管理",
//                'powerid': '74',
                'children': {
                    'monitor': {
                        'text': '成绩管理',
                        'url': '/training/reference/list.jsp',
                    },
                    'monitor': {
                        'text': '成绩查询',
                        'url': '/training/courseware/list.jsp',
                    },
                   
                }
            }
            
        }
    },
    'top5': {
        'text': '工作交流',
//        'powerid': '75',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "消息中心",
//                'powerid': '76',
                'children': {
                    'notice': {
                        'text': '消息中心',
                        'url': '/notice/list.jsp',
                    }
                }
            },
            'menutop2': {
                'text': "通讯录",
//                'powerid': '77',
                'children': {
                    'notice': {
                        'text': '办公室',
                        'url': '/notice/list.jsp',
                    },
                    'notice1': {
                        'text': '选工委',
                        'url': '/notice/list.jsp',
                    },
                    'notice2': {
                        'text': '法工委',
                        'url': '/notice/list.jsp',
                    },
                    'notice3': {
                        'text': '财经委',
                        'url': '/notice/list.jsp',
                    }
                }
            },
            'menutop3': {
                'text': "实时邮箱",
//                'powerid': '78',
                'children': {
                    'notice1': {
                        'text': '写信',
                        'url': '/workexchange/mailbox/write/write.jsp',
                    },
                    'notice2': {
                        'text': '看信',
                        'url': '/workexchange/mailbox/see/list.jsp',
                    },
                    'notice3': {
                        'text': '草稿箱',
                        'url': '/workexchange/mailbox/draft/list.jsp',
                    },
                    'notice4': {
                        'text': '已发送邮件',
                        'url': '/workexchange/mailbox/send/list.jsp',
                    },
                    'notice5': {
                        'text': '已删除邮件',
                        'url': '/workexchange/mailbox/delete/list.jsp',
                    },
                    'notice6': {
                        'text': '通讯录',
                        'url': '/workexchange/mailbox/directories/list.jsp',
                    },
//                    'notice7': {
//                        'text': '代表查询',
//                        'url': '/workexchange/write/list.jsp',
//                    }
                }
            },
            'menutop4': {
                'text': "公众号",
//                'powerid': '79',
                'children': {
                     'notice': {
                        'text': '公众号',
                        'url': '/notice/list.jsp',
                    },
                }
            },
             'menutop5': {
                'text': "工作圈",
//                'powerid': '79',
                'children': {
                     'notice': {
                        'text': '工作圈',
                        'url': '/notice/list.jsp',
                    },
                }
            },
             'menutop6': {
                'text': "即时通讯",
//                'powerid': '79',
                'children': {
                     'notice': {
                        'text': '即时通讯',
                        'url': '/notice/list.jsp',
                    },
                }
            }
        }
    },
    'top6': {
        'text': '双联服务',
        'powerid': '80',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "网上代表联络站",
                'powerid': '81',
                'children': {
                    'notice1': {
                        'text': '联络站管理',
                        'url': '/contactstation/list.jsp',
                        'powerid': '193',
                    },
                    'notice2': {
                        'text': '联络站信息动态',
                        'url': '/contactstation/my/list.jsp',
                        'powerid': '194',
                    },
                    'notice3': {
                        'text': '联络站站点管理',
//                        'url': '/contactstation/substation/list.jsp',
                        'url': '/contactstation/contactstation/list.jsp',

                        'powerid': '251',
                    },
//                    
                     'notice4': {
                        'text': '联络站id管理',
                        'url': '/contactstation/identity/list.jsp',
                        'powerid': '95',
                    },
                    
                    
                     'notice5': {
                        'text': '站长和联系人账号管理',
                        'url': '/contactstation/other/list.jsp',
                        'powerid': '95',
                    },
                    
                    'notice6': {
                        'text': '乡镇人大代表管理',
                        'url': '/contactstation/towndelegate/list.jsp',
                        'powerid': '95',
                    },
                    
                }
            },
            'menutop2': {
                'text': "留言管理",
                'powerid': '246',
                'children': {
                    'notice1': {
                        'text': '留言管理',
                        'url': '/contactstation/leaveword/handle.jsp',
                        'powerid': '248',
                    },
                }
            },
            'menutop3': {
                'text': "代表留言审批",
                'powerid': '247',
                'children': {
                    'notice1': {
                        'text': '代表留言审批',
                        'url': '/contactstation/leaveword/objlist.jsp',
                        'powerid': '192',
                    },
                }
            },
            
            'menutop4': {
                'text': "我的留言",
                'children': {
                    'notice1': {
                        'text': '我的留言',
                        'url': '/contactstation/leaveword/mylist.jsp',
                    },
                }
            },
//            'menutop5': {
//                'text': "工作动态",
//                'powerid': '83',
//                'children': {
//                    'notice': {
//                        'text': '工作动态',
//                        'url': '/delegatexweb/workdynamics/list.jsp?classify=1',
//                    }
//                }
//            },
//            
//             'menutop6': {
//                'text': "通知公告",
//                'powerid': '84',
//                'children': {
//                    'notice': {
//                        'text': '通知公告',
//                        'url': '/delegatexweb/workdynamics/list.jsp?classify=3',
//                    }
//                }
//            },
//            
//            'menutop4': {
//                'text': "代表履职",
//                'powerid': '249',
//                'children': {
//                    'notice': {
//                        'text': '代表履职',
//                        'url': '/delegatexweb/workdynamics/list.jsp?classify=2',
////                        'powerid': '250',
//                    },
//                }
//            },
//            'menutop7': {
//                'text': "代表风采",
//                'powerid': '84', //临时用原来人大代表制度的id
//                'children': {
//                    'notice': {
//                    'text': '代表风采',
//                    'url': '/delegatexweb/workdynamics/list.jsp?classify=4',
//                    }
//                 }
//             }, 
//            
            
            
//            'menutop6': {
//                'text': "人大代表制度",
//                'powerid': '84',
//                'children': {
//                    'notice': {
//                        'text': '人大代表制度',
//                        'url': '/delegatexweb/personsystem/list.jsp',
//                    }
//                }
//            },
//            'menutop4': {
//                'text': "前台链接",
//                'powerid': '249',
//                'children': {
//                    'notice1': {
//                        'text': '前台链接',
//                        'url': '/delegatexweb/gohere.jsp',
//                        'powerid': '250',
//                    },
//                }
//            },
        }
    },
    'top7': {
        'text': '代表网',
        'powerid': '82',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "工作动态",
                'powerid': '83',
                'children': {
                    'notice': {
                        'text': '工作动态',
                        'url': '/delegatexweb/workdynamics/list.jsp',
                    }
                }
            },
            'menutop2': {
                'text': "人大代表制度",
                'powerid': '84',
                'children': {
                    'notice': {
                        'text': '人大代表制度',
                        'url': '/delegatexweb/personsystem/list.jsp',
                    }
                }
            },
//            'menutop3': {
//                'text': "人大代表信息查看",
//                'powerid': '85',
//                'children': {
//                }
//            }
        }
    },
    'top8': {
        'text': '工作交流',
        'powerid': '86',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                },
            },
            'menutop1': {
                'text': "工作交流",
                'children': {
                    'notice': {
                        'text': '工作交流信息',
                        'url': '/poll/list.jsp',
                        'powerid': '87',
                    }
                }
            },
        }
    },
    'top9': {
        'text': '建议议案点评',
        'powerid': '88',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "建议议案点评",
                'children': {
                    'notice': {
                        'text': '点评信息',
                        'url': '/suggest/comment/list.jsp',
                    }
                }
            },
        }
    },
    'top10': {
        'text': '建议议案线索',
        'powerid': '89',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "建议议案线索",
                'children': {
                    'notice': {
                        'text': '线索信息',
                        'url': '/suggest/clue/list.jsp',
                    }
                }
            },
        }
    },
    'top11': {
        'text': '人大监督',
        'powerid': '204',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
         
            'menutop1': {
                'text': "听取和审议专项报告",
                'powerid': '215',
                'children': {
                    'notice': {
                        'text': '我的专项工作报告',
                        'url': '/supervision/specialReport/list_2.jsp?typeid=1',
                        'powerid': '216',
                    },
                    'notice1': {
                        'text': '承办的专项工作报告',
//                        'url': '/supervision/zhifajiancha/receipt/receipt_list.jsp?typeid=2',
                        'url': '/supervision/specialReport/myRecieptlist.jsp?typeid=1',
                        'powerid': '238',
                    },
                    'notice2': {
                        'text': '已完成专项工作报告',
                        'url': '/supervision/specialReport/donelist.jsp?typeid=1',
                        'powerid': '218',
                    },
                }
            },
            
            'menutop2': {
                'text': "财政监督",
                'powerid': '212',
                'children': {
                    'notice': {
                        'text': '我的通知',
                        'url': '/supervision/finance/list.jsp?typeid=2',
                        'powerid': '213',
                    },
                    'notice1': {
                        'text': '承办审查和批准结算',
                        'url': '/supervision/finance/myRecieptlist.jsp?typeid=2',
                        'powerid': '237',
                    },
                    'notice2': {
                        'text': '已完成的审查和批准结算',
                        'url': '/supervision/finance/donelist.jsp?typeid=2',
                        'powerid': '214',
                    },
                    
                    'notice3': {
                     'text': '预算公开',
                     'url': '/supervision/finance/publiclist.jsp?typeid=3',
                     'powerid': '',
                    },
                }
            },
              
            'menutop3': {
                'text': "执法检查",
                'powerid': '212',
                'children': {
                    'notice': {
                        'text': '我的执法检查方案',
                        'url': '/supervision/enforecement/list.jsp?typeid=3',
                        'powerid': '213',
                    },
                    
                    
                    'notice1': {
                        'text': '承办的执法检查',
                        'url': '/supervision/enforecement/myrecievptlist.jsp?typeid=3',
                        'powerid': '237',
                    },
               
                    'notice2': {
                        'text': '已完成的执法检查',
                        'url': '/supervision/enforecement/donelist.jsp?typeid=3',
                        'powerid': '214',
                    },
                    
                    'notice3': {
                        'text': '预审执法检查方案',
                        'url': '/supervision/enforecement/previewlist.jsp?typeid=3',
                        'powerid': '415',
                    },
                    'notice4': {
                        'text': '待出执法检查工作报告',
                        'url': '/supervision/enforecement/workreportlist.jsp?typeid=3',
                        'powerid': '415',
                    },
                }
            },
            
       
              'menutop4':{
                'text': "规范性文件备案审查",
                'powerid': '350',
                'children': {
                    'notice': {
                        'text': '新增规范性文件',
                        'powerid': '355',
                        'url': '/judicsuper/jfxwjba/edit.jsp',
                    },
                    'notice2': {
                        'text': '查看规范性文件',
                        'powerid': '359',
                        'url': '/judicsuper/jfxwjba/list.jsp',
                    },
                    'notice3': {
                        'text': '待办理记录',
                        'powerid': '360',
                        'url': '/judicsuper/jfxwjba/list_1.jsp',
                    },
                    'notice4': {
                        'text': '驳回记录',
                        'powerid': '361',
                        'url': '/judicsuper/jfxwjba/list_2.jsp',
                    },
                    'notice5': {
                        'text': '转办规范性文件',
//                        'powerid': '371',
                        'url': '/judicsuper/jfxwjba/list_3.jsp',
                    },
                    
                }
            },
            
             'menutop5': {
                'text': "专题询问",
                'powerid': '222',
                'children': {
                    'notice': {
                        'text': '我的专题询问',
                        'url': '/supervision/specialinquery/list.jsp?typeid=5',
                        'powerid': '223',
                    },
                    'notice1': {
                        'text': '承办的专题询问',
                        'url': '/supervision/specialinquery/myRecieptlist.jsp?typeid=5',
                        'powerid': '240',
                    },
                    'notice2': {
                        'text': '预审的专题询问',
                        'url': '/supervision/specialinquery/previewlist.jsp?typeid=5',
                        'powerid': '210',
                    },
                    'notice3': {
                        'text': '已完成的专题询问',
                        'url': '/supervision/specialinquery/donelist.jsp?typeid=5',
                        'powerid': '224',
                    },
                    
                }
            },
            
           
           
              'menutop6': {
                'text': "特定问题调查",
                'powerid': '234',
                'children': {
                    'notice': {
                        'text': '我的调查方案',
                        'url': '/supervision/specialproblem/list.jsp?typeid=6',
                        'powerid': '235',
                    },
                    'notice1': {
                        'text': '承办的调查',
                        'url': '/supervision/specialproblem/myRecieptlist.jsp?typeid=6',
                        'powerid': '241',
                    },
                    'notice2': {
                        'text': '已完成的调查',
                        'url': '/supervision/specialproblem/donelist.jsp?typeid=6',
                        'powerid': '236',
                    },        
                }
            },

            
             'menutop7': {
                'text': "撤职案的审议和决定",
                'powerid': '',
                'children': {
                    'notice': {
                        'text': '撤职案的审议和决定',
                        'url': '/supervision/disimissal/list.jsp?typeid=7',
                        'powerid': '',
                    },
                    'notice1': {
                        'text': '承办撤职案的审议和决定',
                        'url': '/supervision/disimissal/myRecieptlist.jsp?typeid=7',
                        'powerid': '',
                    },
                    'notice2': {
                        'text': '已完成职案的审议和决定',
                        'url': '/supervision/disimissal/donelist.jsp?typeid=7',
                        'powerid': '',
                    },
                    
                }
            },
            
            
             'menutop8': {
                'text': "视察",
                'powerid': '205',
                'children': {
                    'notice': {
                        'text': '我的视察方案',
                        'powerid': '206',
                        'url': '/supervision/inspection/list.jsp?typeid=8',
                    },
                    'notice1': {
                        'text': '承办的视察',
                        'url': '/supervision/inspection/myrecievptlist.jsp?typeid=8',
                        'powerid': '207',
                    },
                    'notice2': {
                        'text': '预审的视察',
                        'url': '/supervision/inspection/previewlist.jsp?typeid=8',
                        'powerid': '208',
                    },
//                    'notice3': {
//                        'text': '整改落实报告',
//                        'url': '/supervision/topic/receipt/list.jsp?typeid=8',
//                        'powerid': '209',
//                    },
                    'notice3': {
                        'text': '已完成的视察',
                        'url': '/supervision/inspection/donelist.jsp?typeid=8',
                        'powerid': '211',
                    },
                }
            },
            
             'menutop9': {
                'text': "调研",
                'powerid': '206',
                'children': {
                    'notice': {
                        'text': '我的调研方案',
                        'powerid': '412',
                        'url': '/supervision/investigation/list.jsp?typeid=9',
                    },
                    'notice1': {
                        'text': '承办的调研',
                        'url': '/supervision/investigation/myrecievptlist.jsp?typeid=9',
                        'powerid': '413',
                    },
                    'notice2': {
                        'text': '预审的调研',
                        'url': '/supervision/investigation/previewlist.jsp?typeid=9',
                        'powerid': '209',
                    },
                  
                    'notice3': {
                        'text': '已完成的调研',
                        'url': '/supervision/investigation/donelist.jsp?typeid=9',
                        'powerid': '414',
                    },
                }
            },
            
            
             'menutop10': {
                'text': "新增管理",
                'powerid': '91',  
                'children': {
                  'add': {
                        'text': '新增记录',
                        'url': '/supervision/editInspection.jsp',
                        'powerid': '',
                    },
                }
            }
            
            
            
        }
    },
    'top12': {
        'text': '规范性文件备案审查',
        'powerid': '252',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "规范性文件备案审查",
                'powerid': '253',
                'children': {
                  
                   'notice': {
                        'text': '网上报备',
                        'powerid': '254',
                        'url': '/backups/list.jsp',
                    },
                             
                    'notice1': {
                               'text': '新增规范性文件',
                               'powerid': '355',
                               'url': '/judicsuper/jfxwjba/edit.jsp',
                           },
                           'notice2': {
                               'text': '查看规范性文件',
                               'powerid': '359',
                               'url': '/judicsuper/jfxwjba/list.jsp',
                           },
                           'notice3': {
                               'text': '待办理记录',
                               'powerid': '360',
                               'url': '/judicsuper/jfxwjba/list_1.jsp',
                           },
                           'notice4': {
                               'text': '驳回记录',
                               'powerid': '361',
                               'url': '/judicsuper/jfxwjba/list_2.jsp',
                           },
                           'notice5': {
                               'text': '转办规范性文件',
                               'powerid': '371',
                               'url': '/judicsuper/jfxwjba/list_3.jsp',
                           },   
                           
                    
                           
                        'notice7': {
                        'text': '备案',
                        'url': '/backups/list.jsp',
                        'powerid': '255',    
                    },
                    
                    

                }
            },
            
            
          'menutop2': {
                'text': "综合查询",
//                'powerid': '271',
                'children': {
                    'notice': {
                        'text': '综合查询',
//                        'powerid': '276',
                        'url': '/judicsuper/jfxwjba/list_3.jsp',
                    },
                   
                }
            },    
            
                 'menutop3': {
                'text': "规范性文件库",
//                'powerid': '271',
                'children': {
                    'notice': {
                        'text': '规范性文件库',
//                        'powerid': '276',
                        'url': '/judicsuper/jfxwjba/list_3.jsp',
                    },
                   
                }
            },       
            
        }
    },
    'top13': {
        'text': '官网后台',
        'powerid': '256',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "外网门户",
                'powerid': '257',
                'children': {
                    'notice1': {
                        'text': '人大要闻发布管理',
                        'powerid': '258',
                        'url': '/website/list.jsp',
                    },
                    'notice2': {
                        'text': '通知公告发布管理',
                        'powerid': '292',
                        'url': '/website/notice/list.jsp',
                    },
                    'notice3': {
                        'text': '立法工作发布管理',
                        'powerid': '293',
                        'url': '/website/legiswork/list.jsp',
                    },
                    'notice4': {
                        'text': '乡镇人大发布管理',
                        'powerid': '294',
                        'url': '/website/townews/list.jsp',
                    },
                    'notice5': {
                        'text': '监督工作发布管理',
                        'powerid': '295',
                        'url': '/website/superon/list.jsp',
                    },
                    'notice6': {
                        'text': '代表工作发布管理',
                        'powerid': '296',
                        'url': '/website/reprwork/list.jsp',
                    },
                    'notice7': {
                        'text': '最新公告发布管理',
                        'powerid': '297',
                        'url': '/website/latment/list.jsp',
                    },
                    'notice8': {
                        'text': '决议决定发布管理',
                        'powerid': '298',
                        'url': '/website/resodec/list.jsp',
                    },
                    'notice9': {
                        'text': '选举任免发布管理',
                        'powerid': '299',
                        'url': '/website/elapprem/list.jsp',
                    },                   
                    'notice10': {
                        'text': '电子版发布管理',
                        'powerid': '301',
                        'url': '/website/elvrupec/list.jsp',
                    },
                    'notice11': {
                        'text': '会议内容发布管理',
                        'powerid': '259',
                        'url': '/website/meeting/list.jsp',
                    },
                    'notice12': {
                        'text': '公报内容发布管理',
                        'powerid': '260',
                        'url': '/website/bulletin/list.jsp',
                    },
                    'notice13': {
                        'text': '主任信息管理',
                        'powerid': '261',
                        'url': '/website/director/list.jsp',
                    },
                    'notice14': {
                        'text': '风景信息管理',
                        'powerid': '266',
                        'url': '/website/scenery/list.jsp',
                    },
                    'notice15': {
                        'text': '概况信息管理',
                        'powerid': '267',
                        'url': '/website/survey/list.jsp',
                    },
                    'notice16': {
                        'text': '专题集锦管理',
                        'powerid': '410',
                        'url': '/website/ztjj/list.jsp',
                    },
                     'notice17': {
                        'text': '机关建设发布管理',
                        'powerid': '300',
                        'url': '/website/parbugov/list.jsp',
                    },
                    
                     'notice18': {
                        'text': '调查研究发布管理',
                        'powerid': '416',
                        'url': '/website/investigation/list.jsp',
                    },
                    'notice19': {
                        'text': '议案建议发布管理',
                        'powerid': '417',
                        'url': '/website/proposal/list.jsp',
                    },
                    'notice20': {
                        'text': '财政发布管理',
                        'powerid': '419',
                        'url': '/website/finance/list.jsp',
                    },
                    'notice21': {
                        'text': '图片新闻管理',
                        'powerid': '418',
                        'url': '/website/horselight/list.jsp',
                    },
                    'notice22': {
                        'text': '头条新闻管理',
                        'powerid': '',
                        'url': '/website/headline/list.jsp',
                    },
                     'notice23': {
                        'text': '人大代表',
                        'powerid': '',
                        'url': '/website/delegation/list.jsp',
                    },
                    
                     'notice24': {
                        'text': '人大杂志',
                        'powerid': '',
                        'url': '/website/magazine/list.jsp',
                    },
                    
                      'notice25': {
                        'text': '常委会委员管理',
                        'powerid': '',
                        'url': '/website/committee/list.jsp',
                    },
                }
            },
             'menutop2': {
                'text': "专题集锦与代表风采",
                'powerid': '356',
                'children': {
                    'notice': {
                        'text': '专题集锦添加',
                        'powerid': '357',
//                        'url': '/wangzhan/add/addjijin.jsp',
                        'url': '/website/collectionImage/list.jsp',
                    },
                    'notice1': {
                        'text': '代表风采添加',
                        'url': '/wangzhan/add/addfengcai.jsp',
                        'powerid': '358',
                    },

                }
            },
            
            
            'menutop3': {
                'text': "通知发布",
                'powerid': '356',
                'children': {
                    'notice': {
                        'text': '通知发布',
                        'url': '/newinformation/list.jsp',
                    }
                }
            }        
        }
    },
    'top14' : {
        'text' : '信访工作系统',
        'powerid':'270',
        'children':{
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            
            'menutop1': {
                'text': "大数据分析",
   //           'powerid': '71',
                'children': {
                    'monitor': {
                    'text': '大数据分析',
                    'url': '/visualdata/leavis.html',
                    }
                }
            },    
            
            'menutop2': {
                'text': "业务受理",
                'powerid': '271',
                'children': {
                    'notice4': {
                        'text': '首页',
                        'powerid': '276',
                        'url': '/leavis/list.jsp',
                    },
                    'notice': {
                        'text': '来信登记',
                        'powerid': '272',
                        'url': '/leavis/letregtion/list.jsp',
                    },
                    'notice1': {
                        'text': '来访登记',
                        'powerid': '273',
                        'url': '/leavis/visregis/list.jsp',
                    },
                    'notice2': {
                        'text': '网上来信',
                        'powerid': '274',
                        'url': '/leavis/emailtion/list.jsp',
                    },
                    'notice3': {
                        'text': '上级转交件',
                        'powerid': '275',
                        'url': '/leavis/dohaovsup/list.jsp',
                    },
                }
            },
            'menutop3':{
                'text': "业务办理",
                'powerid': '277',
                'children':{
                    'notice': {
                        'text': '个人待办',
                        'powerid': '278',
                        'url': '/leavis/persontd/list.jsp',
                    },
                    'notice1': {
                        'text': '已办列表',
                        'powerid': '279',
                        'url': '/leavis/completlist/list.jsp',
                    },
                    'notice2': {
                        'text': '正办列表',
                        'powerid': '280',
                        'url': '/leavis/goinglist/list.jsp',
                    },
                    'notice3': {
                        'text': '待审核列表',
                        'powerid': '281',
                        'url': '/leavis/tbrevilist/list.jsp',
                    },
                }
            },
             'menutop4':{
                'text': "信访告知",
//                'powerid': '282',
                'children':{
                    'notice': {
                        'text': '信访告知',
//                        'powerid': '283',
                        'url': '/leavis/simplque/list.jsp',
                    },
                }
            },
             'menutop5':{
                'text': "统计分析",
//                'powerid': '282',
                'children':{
                    'notice': {
                        'text': '统计分析',
//                        'powerid': '283',
                        'url': '/leavis/simplque/list.jsp',
                    },
                }
            },
              'menutop6':{
                'text': "信访件案例公开",
//                'powerid': '282',
                'children':{
                    'notice': {
                        'text': '信访件案例公开',
//                        'powerid': '283',
                        'url': '/leavis/simplque/list.jsp',
                    },
                }
            },
            'menutop7':{
                'text': "查询检索",
                'powerid': '282',
                'children':{
                    'notice': {
                        'text': '简单查询',
                        'powerid': '283',
                        'url': '/leavis/simplque/list.jsp',
                    },
                }
            }
        }
    },
//    'top15': {
//        'text': '立法工作平台',
//        'powerid': '287',
//        'children': {
//            'menutop': {
//                'text': "功能导航",
//                'children': {
//                }
//            },
//            'menutop1': {
//                'text': "立法工作平台",
//                'powerid': '288',
//                'children': {
//                    'notice': {
//                        'text': '立法规划',
//                        'powerid': '289',
//                        'url': '/legislative/Legislativeplanning/list.jsp',
//                    },
//                    'notice2': {
//                        'text': '立法项目库',
//                        'powerid': '290',
//                        'url': '/legislative/LegislativeProjectLibrary/list.jsp',
//                    },
//                    'notice3': {
//                        'text': '公开条例',
//                        'powerid': '291',
//                        'url': '/legislative/disclosureRegulations/list.jsp',
//                    },
//                }
//            },
//        }
//    },
    
    
     'top15': {
        'text': '立法工作平台',
        'powerid': '287',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            
            'menutop0': {
                'text': "首页",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'powerid': '289',
                        'url': '/visualdata/law.html',
                    },                    
                }
            },
            
            'menutop1': {
                'text': "法律法规库",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '法律法规库',
                        'powerid': '289',
                        'url': '/legislative/lawAndregulation/list.jsp',
                    },                    
                }
            },
            
            'menutop2': {
                'text': "专家库管理",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '专家库管理',
                        'powerid': '289',
                        'url': '/legislative/expert/list.jsp',
                    },
                }
            },
            
            
            'menutop3': {
                'text': "立法规划",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '立法规划年度管理',
                        'powerid': '289',
                        'url': '/legislative/programofLegislation/list.jsp',
                    },
                    'notice2': {
                        'text': '立法规划项目征集',
                        'powerid': '290',
                        'url': '/legislative/LegislativeProject/list.jsp',
                    },
                    'notice3': {
                        'text': '立法规划管理',
                        'powerid': '291',
                        'url': '/legislative/legislationManage/list.jsp',
                    },
                }
            },
            
            
            'menutop4': {
                'text': "立法计划",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '立法计划项目征集',
                        'powerid': '289',
                        'url': '/legislative/plan/list.jsp',
                    },
                    'notice2': {
                        'text': '立法计划管理',
                        'powerid': '290',
                        'url': '/legislative/planmanage/list.jsp',
                    },                   
                }
            },
            
            
            
            'menutop5': {
                'text': "立法过程",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '立法执行初审',
                        'powerid': '289',
                        'url': '/legislative/legislationprocess/list.jsp',
                    },
                    'notice2': {
                        'text': '立法执行一审',
                        'powerid': '290',
                        'url': '/legislative/legistationimpemention1/list.jsp',
                    },
                    'notice3': {
                        'text': '立法执行二审',
                        'powerid': '291',
                        'url': '/legislative/legistationimpemention2/list.jsp',
                    },
                    'notice4': {
                        'text': '立法执行三审',
                        'powerid': '291',
                        'url': '/legislative/legistationimpemention3/list.jsp',
                    },
                    'notice5': {
                        'text': '立法执行会议表决',
                        'powerid': '291',
                        'url': '/legislative/legistationvoting/list.jsp',
                    },
                    'notice6': {
                        'text': '立法执行查询列表',
                        'powerid': '291',
                        'url': '/legislative/legistationquery/list.jsp',
                    },
                }
            },
            
            
            
            'menutop6': {
                'text': "立法评估",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '立法前评估',
                        'powerid': '289',
                        'url': '/legislative/prelegislationevaluation/list.jsp',
                    },
                    'notice2': {
                        'text': '立法后评估',
                        'powerid': '290',
                        'url': '/legislative/postlegislationevaluation/list.jsp',
                    },                  
                }
            },
            
            
                'menutop7': {
                'text': "通知公告",
                'powerid': '288',
                'children': {
                    'notice': {
                        'text': '通知公告',
                        'powerid': '289',
                        'url': '/legislative/notice/list.jsp',
                    },
                }
            },
            
            'menutop8': {
            'text': "社会参与立法系统",
            'powerid': '288',
            'children': {
                'notice': {
                    'text': '意见征集',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },
            }
            },
            
            
        
        
           'menutop9': {
            'text': "立法管理",
            'powerid': '288',
            'children': {
                'notice': {
                    'text': '立法调研',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },
                'notice1': {
                    'text': '立法起草',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },
                'notice2': {
                    'text': '立法讨论',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },
                'notice3': {
                    'text': '立法表决',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },
                'notice4': {
                    'text': '立法公开',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },  
                
            }
            },
            
            
            'menutop10': {
            'text': "立法智能辅助系统",
            'powerid': '288',
            'children': {
                'notice': {
                    'text': '智能对比',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },
                'notice1': {
                    'text': '动态维护',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },
                'notice2': {
                    'text': '立法档案管理',
                    'powerid': '289',
                    'url': '/legislative/opinion/list.jsp',
                },
               
                
            }
            },
            
        }
    },
    
    
    
    
    
    
//    'top16':{
//        'text': '司法监督系统',
//        'powerid': '304',
//        'children':{
//            'menutop': {
//                'text': "功能导航",
//                'children': {
//                }
//            },
//            'menutop1':{
//                'text': "一年三问",
//                'powerid': '305',
//                'children': {
//                    'notice': {
//                        'text': '一年三问通知',
//                        'powerid': '306',
//                        'url': '/judicsuper/thrques/list.jsp',
//                    },
//                    'notice2': {
//                        'text': '年初安排',
//                        'powerid': '307',
//                        'url': '/judicsuper/arrbegye/list.jsp',
//                    },
//                    'notice3': {
//                        'text': '已归档年初安排',
//                        'powerid': '308',
//                        'url': '/judicsuper/',
//                    },
//                    'notice4': {
//                        'text': '监督管理',
//                        'powerid': '309',
//                        'url': '/judicsuper/',
//                    },
//                    'notice5': {
//                        'text': '年中进度报告',
//                        'powerid': '310',
//                        'url': '/judicsuper/',
//                    },
//                    'notice6': {
//                        'text': '年末结果报告',
//                        'powerid': '311',
//                        'url': '/judicsuper/',
//                    },
//                    'notice7': {
//                        'text': '已归档监督工作',
//                        'powerid': '312',
//                        'url': '/judicsuper/',
//                    },
//                    
//                }
//            }
//        }
//    },

    'top16':{
        'text': '司法监督系统',
        'powerid': '304',
        'children':{
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1':{
                'text': "述职述法线索征集管理",
                'powerid': '305',
                'children': {   
                    
                    'notice1': {
                        'text': '司法监督议题线索',
                        'powerid': '306',
                        'url': '/judicsuper/colljusupis/list.jsp',
                    },
                    'notice2': {
                        'text': '述法线索',
                        'powerid': '307',
                        'url': '/judicsuper/collnarcl/list.jsp',
                    },
                    'notice3': {
                        'text': '办案质量检查线索',
                        'powerid': '308',
                        'url': '/judicsuper/collhaquin/list.jsp',
                    },
                    'notice4': {
                        'text': '其他线索',
                        'powerid': '370',
                        'url': '/judicsuper/other/list.jsp',
                    },
//                    'notice4': {
//                        'text': '座谈会',
//                        'powerid': '314',
//                        'url': '/judicsuper/forum/list.jsp',
//                    },
//                    'notice5': {
//                        'text': '论证会',
//                        'powerid': '315',
//                        'url': '/judicsuper/demeeting/list.jsp',
//                    },
//                    'notice6': {
//                        'text': '听证会',
//                        'powerid': '316',
//                        'url': '/judicsuper/hearing/list.jsp',
//                    },
//                    'notice7': {
//                        'text': '群众意见',
//                        'powerid': '317',
//                        'url': '/judicsuper/opotmas/list.jsp',
//                    }
                }
            },
            'menutop2':{
                'text': "司法监督管理",
                'powerid': '309',
                'children': {
                    'notice': {
                        'text': '司法监督管理',
                        'powerid': '310',
                        'url': '/judicsuper/judsupadm/list.jsp',
                    },
                    'notice2': {
                        'text': '已归档司法监督',
                        'powerid': '311',
                        'url': '/judicsuper/filjudsupadm/list.jsp',
                    },
                }
            },
            'menutop3':{
                'text': "精准信息推送",
                'powerid': '312',
                'children': {
                    'notice': {
                        'text': '精准信息推送',
                        'powerid': '323',
                        'url': '/judicsuper/thrques/list.jsp',
                    },
                    
                }
            },
//            'menutop4':{
//                'text': "规范性文件备案",
//                'powerid': '350',
//                'children': {
//                    'notice': {
//                        'text': '新增规范性文件',
//                        'powerid': '355',
//                        'url': '/judicsuper/jfxwjba/edit.jsp',
//                    },
//                    'notice2': {
//                        'text': '查看规范性文件',
//                        'powerid': '359',
//                        'url': '/judicsuper/jfxwjba/list.jsp',
//                    },
//                    'notice3': {
//                        'text': '待办理记录',
//                        'powerid': '360',
//                        'url': '/judicsuper/jfxwjba/list_1.jsp',
//                    },
//                    'notice4': {
//                        'text': '驳回记录',
//                        'powerid': '361',
//                        'url': '/judicsuper/jfxwjba/list_2.jsp',
//                    },
//                }
//            },
            
//             'menutop5':{
//                'text': "法治信息",
//                'powerid': '403',
//                'children': {
//                    'notice': {
//                        'text': '法律文书信息模块',
//                        'powerid': '404',
//                        'url': 'https://www.12309.gov.cn/12309/zjxflws/index.shtml',
//                    },
//                    'notice3': {
//                        'text': '庭审直播与点播',
//                        'powerid': '406',
//                        'url': 'http://ts.hncourt.gov.cn/',
//                    },
//                    'notice2': {
//                        'text': '司法公开及诉讼服务信息模块',
//                        'powerid': '405',
//                        'url': 'https://flk.npc.gov.cn/',
//                    },
//                    
//                }
//            },
        }
    },
    'top17': {
        'text': '选举任免系统',
        'powerid': '313',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "考核管理平台",
                'powerid': '322',
                'children': {
                    'notice': {
                        'text': '考生管理',
                        'powerid': '314',
                        'url': 'electionAppointmentAndRemovalSystem/candidateManagement/list.jsp',
                    },
                    'notice1': {
                        'text': '题库管理',
                        'powerid': '321',
                        'url': '/electionAppointmentAndRemovalSystem/questionBankManagement/list.jsp',
                    },
                    'notice2': {
                        'text': "考试管理",
                        'powerid': '315',
                        'url': '/electionAppointmentAndRemovalSystem/examManagement/list.jsp',
                    },
                    'notice3': {
                        'text': "试卷管理",
                        'powerid': '316',
                        'url': '/electionAppointmentAndRemovalSystem/testPaperManagement/list.jsp',
                    },
                    'notice4': {
                        'text': "题库文件",
                        'powerid': '317',
                        'url': '/electionAppointmentAndRemovalSystem/questionbankfile/list.jsp',
                    },
                }
            },
            'menutop2': {
                'text': "查询统计",
                'powerid': '318',
                'children': {
                    'notice': {
                        'text': '考试统计',
                        'powerid': '319',
                        'url': '/electionAppointmentAndRemovalSystem/examStatistics/list.jsp',
                    },
                    'notice2': {
                        'text': '考生统计',
                        'powerid': '320',
                        'url': '/electionAppointmentAndRemovalSystem/candidateStatistics/list.jsp',
                    },
                }
            },
            
            'menutop3': {
               'text': "人事任免",
               'powerid': '322',
               'children': {
                   'notice': {
                       'text': '选举',
                       'powerid': '314',
                       'url': 'electionAppointmentAndRemovalSystem/appointmentManage/list.jsp',
                   },
                   'notice1': {
                       'text': '任职',
                       'powerid': '321',
                       'url': '/electionAppointmentAndRemovalSystem/appointmentManage/list.jsp',
                   },
                   'notice2': {
                       'text': "免职",
                       'powerid': '315',
                       'url': '/electionAppointmentAndRemovalSystem/appointmentManage/list.jsp',
                   },
                   'notice3': {
                       'text': "离职",
                       'powerid': '316',
                       'url': '/electionAppointmentAndRemovalSystem/appointmentManage/list.jsp',
                   },                 
               }
            },
            
            
        }
    },
    
    
    
     'top18': {
        'text': '履职测评系统',
        'powerid': '330',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
          
            'menutop1': {
                'text': "建议议案测评系统",
                'powerid': '332',
                'children': {    
                  
                    'notice1': {
                        'text': '建议测评',
                        'powerid': '336',
                        'url': '/listManager/evaluateList.jsp',
                    },
                    'notice2': {
                        'text': "议案测评",
                        'powerid': '337',
                        'url': '/listManager/evaluatebillList.jsp',
                    },
                    'notice3': {
                        'text': '满意率统计',
                        'powerid': '335',
                        'url': '/opinion/evaluation/totalEvaluationList.jsp',
                    },
                    
                   
                }
            },
            'menutop2': {
                'text': "人大监督测评系统",
                'powerid': '333',
                'children': {
                    'notice1': {
                        'text': '听取和审议专题报告',
                        'powerid': '334',
                        'url': '/evaluation/supervision/specialReportlist_2.jsp',
                    },
                    'notice2': {
                        'text': '执法检查',
                        'powerid': '338',
                        'url': '/evaluation/supervision/enforecementlist.jsp',
                    },
                     'notice3': {
                        'text': '专题询问',
                        'powerid': '339',
                        'url': '/evaluation/supervision/specialinquerylist.jsp',
                    },
                     'notice4': {
                        'text': '视察',
                        'powerid': '340',
                        'url': '/evaluation/supervision/inspectionlist.jsp',
                    },
                     'notice5': {
                        'text': '调研',
                        'powerid': '341',
                        'url': '/evaluation/supervision/investigationlist.jsp',
                    },
                }
            },
            
             'menutop3': {
                'text': "投票系统",
                'powerid': '333',
                'children': {
                    'notice1': {
                        'text': '投票列表',
                        'powerid': '334',
                        'url': '/evaluation/voteActivity/list.jsp',
                    },               
                }
            },
              
            'menutop4': {
              'text': "履职排行榜",
              'powerid': '331',
              'children': {
                  'notice': {
                      'text': '查看排行榜',
                      'powerid': '',
                      'url': '/lvzhilist/ranklist.jsp',
                  },

              }
          },
            
            
        }
    },
    
    
//     汝州二期招标
     'top19': {
        'text': '人大决策库系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            
 
            
            'menutop1': {
                'text': "改革创新",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '人大制度',
                        'url': '/makepolicy/innovation/list.jsp',
                    },
                    'monitor1': {
                        'text': '立法研究',
                        'url': '/makepolicy/innovation/list1.jsp',
                    },
                    'monitor2': {
                        'text': '监督研究',
                        'url': '/makepolicy/innovation/list2.jsp',
                    },
                    'monitor3': {
                        'text': '代表工作',
                        'url': '/makepolicy/innovation/list3.jsp',
                    },
                    'monitor4': {
                        'text': '自身建设',
                        'url': '/makepolicy/innovation/list4.jsp',
                    },
                     'monitor5': {
                        'text': '民主政治建设',
                        'url': '/makepolicy/innovation/list5.jsp',
                    },
                }
            },
            'menutop2': {
                'text': "人大动向",
//                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '全国动向',
                        'url': '/makepolicy/trend/list.jsp',
                    },
                    'monitor1': {
                        'text': '省外动向',
                        'url': '/makepolicy/trend/list1.jsp',
                    },
                    'monitor2': {
                        'text': '省内动向',
                        'url': '/makepolicy/trend/list2.jsp',
                    } 
                }
            },
             'menutop3': {
                'text': "国际视野",
//                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '海外会议',
                        'url': '/makepolicy/international/list.jsp',
                    },
                     'monitor1': {
                        'text': '经验参考',
                        'url': '/makepolicy/international/list1.jsp',
                    }
                }
            },
            
             'menutop4': {
                'text': "国情省情市情",
//                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '国情省情市情',
                        'url': '/makepolicy/lecture/list.jsp',
                    }
                }
            },
            
             'menutop5': {
                'text': "社会热点",
//                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '专家观点',
                        'url': '/makepolicy/sociaty/list.jsp',
                    },
                    'monitor1': {
                        'text': '社会舆情',
                        'url': '/makepolicy/sociaty/list1.jsp',
                    }
                }
            },
            
             'menutop6': {
                'text': "决策参考",
//                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '领导决策',
                        'url': '/makepolicy/reference/list.jsp',
                    },
                    'monitor1': {
                        'text': '信息商报',
                        'url': '/makepolicy/reference/list1.jsp',
                    },
                    'monitor2': {
                        'text': '专题参阅',
                        'url': '/makepolicy/reference/list2.jsp',
                    },
//                    'monitor3': {
//                        'text': '重大议题',
//                        'url': '/makepolicy/reference/list3.jsp',
//                    },
                    'monitor4': {
                        'text': '原文参考',
                        'url': '/makepolicy/reference/list4.jsp',
                    }
                }
            },
            
            
              'menutop7': {
                'text': "履职参考",
//                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '基础知识',
                        'url': '/makepolicy/activityreference/list.jsp',
                    },
                    'monitor1': {
                        'text': '经验交流',
                        'url': '/makepolicy/activityreference/list1.jsp',
                    },
                    'monitor2': {
                        'text': '议案建议',
                        'url': '/makepolicy/activityreference/list2.jsp',
                    },
                    'monitor3': {
                        'text': '明星代表',
                        'url': '/makepolicy/activityreference/list3.jsp',
                    },
                    'monitor4': {
                        'text': '专题研习',
                        'url': '/makepolicy/activityreference/list4.jsp',
                    }
                }
            },
            
             'menutop8': {
                'text': "代表知识库",
//                'powerid': '72',
                'children': {
                    'monitor': {
                        'text': '代表知识库',
                        'url': '/makepolicy/knowledge/list.jsp',
                    }
                }
            },
            
            'menutop9': {
                'text': "人才专家库",
//                'powerid': '73',
                'children': {
                    'monitor': {
                        'text': '统筹推进立法专家库',
                        'url': '/makepolicy/expert/list.jsp',
                    },
                    'monitor1': {
                        'text': '专门委员会专家顾问团',
                        'url': '/makepolicy/expert/list1.jsp',
                    },
                    'monitor2': {
                        'text': '人大代表履职顾问等专家库',
                        'url': '/makepolicy/expert/list2.jsp',
                    }
                }
            },
            
            
            'menutop10': {
                'text': "重大议题",
//                'powerid': '73',
                'children': {
                    'monitor13': {
                        'text': '2022年两会热点议题',
                        'url': '/makepolicy/topics/topics13/list.jsp?topics=13',
                    },
                    'monitor12': {
                        'text': '2021年两会热点议题',
                        'url': '/makepolicy/topics/topics12/list.jsp?topics=12',
                    },
                    'monitor11': {
                        'text': '2020年两会热点议题',
                        'url': '/makepolicy/topics/topics11/list.jsp?topics=11',
                    },
                    'monitor10': {
                        'text': '2019年两会热点议题',
                        'url': '/makepolicy/topics/topics10//list.jsp?topics=10',
                    },
                     'monitor9': {
                        'text': '2018年两会热点议题',
                        'url': '/makepolicy/topics/topics9/list.jsp?topics=9',
                    },
                    'monitor8': {
                        'text': '2017年两会热点议题',
                        'url': '/makepolicy/topics/topics8/list.jsp?topics=8',
                    },
                    
                    'monitor7': {
                        'text': '2016年两会热点议题',
                        'url': '/makepolicy/topics/topics7/list.jsp?topics=7',
                    },       
                    
                    'monitor6': {
                        'text': '2015年两会热点议题',
                        'url': '/makepolicy/topics/topics6/list.jsp?topics=6',
                    },
                    
                  'monitor5': {
                        'text': '2014年两会热点议题',
                        'url': '/makepolicy/topics/topics5/list.jsp?topics=5',
                    },    
                 'monitor4': {
                        'text': '2013年两会热点议题',
                        'url': '/makepolicy/topics/topics4//list.jsp?topics=4',
                    },    
                 'monitor3': {
                        'text': '2012年两会热点议题',
                        'url': '/makepolicy/topics/topics3/list.jsp?topics=3',
                    },        
                'monitor2': {
                        'text': '2011年两会热点议题',
                        'url': '/makepolicy/topics/topics2/list.jsp?topics=2',
                    }, 
                
                'monitor1': {
                        'text': '2010年两会热点议题',
                        'url': '/makepolicy/topics/topics1/list.jsp?topics=1',
                    },     
            
            
                    
                }
            },
            
          
        }
    },
    

    
    //  司法联网监督管理
    'top20': {
        'text': '信访案件监督',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            
            'menutop0': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '数据统计',
                        'url': '/visualdata/judicailHomepage.html',
                    }
                }
            },    

            'menutop1': {
                   'text': "司法机关图表分析",
   //                'powerid': '71',
                   'children': {
                       'monitor': {
                           'text': '市中级法院',
                            'url': '/visualdata/IntermediateCourt.html',
                       },
                       'monitor1': {
                           'text': '市检察院',
                            'url': '/visualdata/procuratorate.html',
                           
                       },
                       'monitor2': {
                           'text': '市公安局/司法局',
                            'url': '/visualdata/JudicialBureau.html',
                       },
                       'monitor3': {
                           'text': '市监察委',
                            'url': '/visualdata/Supervisorycommittee.html',
                       }
                       
                   }
               },    
            
             'menutop2': {
                   'text': "案件程序性监督",
   //                'powerid': '71',
                   'children': {
                       'monitor': {
                           'text': '案件程序性监督',
                           'url': '/netsupervision/judicial/list.jsp',
                       }
                   }
               },    
            'menutop3': {
                'text': "信访案件监督",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '信访案件监督',
                        'url': '/netsupervision/judicial/list.jsp',
                    }
                }
            },
             
            'menutop3': {
                'text': "法律文书监督",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '法律文书监督',
                        'url': '/netsupervision/judicial/list.jsp',
                    }
                }
            },
            
            
         'menutop4': {
                'text': "申诉控告监督",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '待办事项',
                        'url': '/netsupervision/judicial/list.jsp',
                    },
                     'monitor1': {
                        'text': '已办事项',
                        'url': '/netsupervision/judicial/list.jsp',
                    }
                }
            },    
            
        'menutop5': {
                'text': "司法人员履职监督",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '履职数据分析',
                        'url': '/netsupervision/judicial/list.jsp',
                    },
                     'monitor1': {
                        'text': '履职报告',
                        'url': '/netsupervision/judicial/list.jsp',
                    }
                }
            },        
            
 
        }
    },
    
    
    //     重大决定
     'top21': {
        'text': '重大决定',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '数据统计',
                        'url': '/visualdata/decision.html',
                    }
                }
            },

          
        }
    },
    
    
    
    
    
      //  经济运行联网监督管理
    'top27': {
        'text': '经济运行联网监督管理',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "经济运行动态分析",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '经济运行动态分析',
                        //'url': '/netsupervision/economy/statistics/list.jsp',
                        'url': '/visualdata/economy.html',
                        
                    }
                }
            },      
            
            'menutop2': {
                'text': "重点项目建设",
//                'powerid': '71',
                'children': {
                    'notice1': {
                        'text': '重点项目建设',
                        'url': '/netsupervision/economy/projection/list.jsp',
                    }
                }
            },      
            
            'menutop3': {
                'text': "文件管理",
//                'powerid': '71',
                'children': {
                    'notice2': {
                        'text': '文件管理',
                        'url': '/netsupervision/economy/filemanager/list.jsp',
                    }
                }
            },      
            
        }
    },
    
    
  
    
     //  民生实事票决系统
    'top28': {
        'text': '民生实事票决系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "候选项目录入",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '候选项目录入',
                        'url': '/livelihood/candidatproject/list.jsp',
                    }
                }
            },      
            
            'menutop2': {
                'text': "项目审议管理",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '项目审议管理',
                        'url': '/livelihood/review/list.jsp',
                    }
                }
            },      
            
            'menutop3': {
                'text': "项目票决结果录入",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '医疗卫生监督',
                        'url': '/livelihood/votingresult/list.jsp',
                    }
                }
            },      
            'menutop4': {
                'text': "项目管理",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '项目管理',
                        'url': '/livelihood/management/list.jsp',
                    }
                }
            },                  
            'menutop5': {
                'text': "项目监督",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '项目监督',
                        'url': '/livelihood/supervision/list.jsp',
                    }
                }
            },                   
            'menutop6': {
                'text': "项目评估",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '项目评估',
                        'url': '/livelihood/evaluation/list.jsp',
                    }
                }
            },                                          
            'menutop7': {
                'text': "项目统计分析",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '项目统计分析',
                        'url': '/livelihood/stastics/list.jsp',
                    }
                }
            },                                      
        }
    },
    
    
      //  科教文卫联网监督管理
    'top29': {
        'text': '科教文卫监督管理',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
          'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '数据统计',
//                        'url': '/netsupervision/culture/technology/list.jsp',
                        'url': '/visualdata/culture.html',

                    }
                }
            },          
            
            'menutop2': {
                'text': "科技创新监督",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '科技创新监督',
                        'url': '/netsupervision/culture/technology/list.jsp',
                    }
                }
            },      
            
            'menutop3': {
                'text': "教育文化监督",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '教育文化监督',
                        'url': '/netsupervision/culture/education/list.jsp',
                    }
                }
            },      
            
            'menutop4': {
                'text': "医疗卫生监督",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '医疗卫生监督',
                        'url': '/netsupervision/culture/medicalcare/list.jsp',
                    }
                }
            },      
            
            
        }
    },
    
    
    
      //  民族侨外监督
    'top30': {
        'text': '民族侨外监督',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
//                        'url': '/visualdata/ethnic.html',
                        'url': '/netsupervision/ethnic/nation/graphics.jsp',

                    }
                }
            },     
            
            'menutop2': {
                'text': "汝州名族",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '汝州名族',
                        'url': '/netsupervision/ethnic/nation/list.jsp',
                    }
                }
            },      
            
            'menutop3': {
                'text': "汝州宗教",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '汝州宗教',
                        'url': '/netsupervision/ethnic/religion/list.jsp',
                    }
                }
            },      
            
            'menutop4': {
                'text': "政策法规",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '政策法规',
                        'url': '/netsupervision/ethnic/policy/list.jsp',
                    }
                }
            },     
            
//            'menutop5': {
//                'text': "公告管理",
////                'powerid': '71',
//                'children': {
//                    'notice': {
//                        'text': '公告管理',
//                        'url': '/netsupervision/ethnic/notice/list.jsp',
//                    }
//                }
//            },                  
            
            
        }
    },
    
    
       //  农业农村
    'top31': {
        'text': '农业农村监督',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
//                        'url': '/netsupervision/agriculture/keywork/graphics.jsp',
                        'url': '/visualdata/agriculture.html',

                    }
                }
            },          
            
            'menutop2': {
                'text': "重点工作",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '重点工作',
                        'url': '/netsupervision/agriculture/keywork/list.jsp',
                    }
                }
            },      
            
            'menutop3': {
                'text': "公告",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '公告',
                        'url': '/netsupervision/agriculture/notice/list.jsp',
                    }
                }
            },           
            
            'menutop4': {
            'text': "文档",
//                'powerid': '71',
            'children': {
                'notice': {
                    'text': '文档',
                    'url': '/netsupervision/agriculture/document/list.jsp',
                }
            }
        },           
            
        }
    },
    
    
    //  城乡建设监督
    'top32': {
        'text': '城乡建设监督',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/countrybuilding.html',

                    },
                    'notice1': {
                        'text': '待审批',
                        'url': '/netsupervision/countrybuilding/building/list.jsp',

                    },
                    'notice2': {
                        'text': '已审批',
                        'url': '/netsupervision/countrybuilding/building/list2.jsp',

                    } ,
                    'notice3': {
                     'text': '已驳回',
                     'url': '/netsupervision/countrybuilding/building/list3.jsp',

                    } 
                }
            },      
            
            
        }
    },
    
    
    
     //  选民登记系统
    'top33': {
        'text': '选民登记系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/registry.html',

                    },
                    
                    'notice1': {
                        'text': '选民登记信息',
                        'url': '/netsupervision/registration/list.jsp',

                    },                                                   
                }
            },
            
            'menutop2': {
                'text': "选区管理",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '选区管理',
                        'url': '/netsupervision/registration/constituency/list.jsp',

                    },                       
                }
            },                                   
            
        }
    },
    
 //  代表选举系统
    'top34': {
        'text': '代表选举系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/election.html',

                    },
                    
                    'notice1': {
                        'text': '代表选举信息',
                        'url': '/visualdata/registry.html',

                    }
                    
                }
            },                          
        }
    },
    
    //  矛调中心系统
    'top35': {
        'text': '矛调中心系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/conflict.html',

                    },
                    
                    'notice1': {
                        'text': '代表选举信息',
                        'url': '/visualdata/registry.html',

                    }
                    
                }
            },                          
        }
    },
    

    
     //  智慧党建
    'top36': {
        'text': '党建系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '系统入口',
//                        'url': '/visualdata/party.html',
                        'url': '/http://ypt.cdlhyj.com/web/login',
                        

                    },                 
                    
                }
            },            
//         'menutop2': {
//               'text': "党员管理",
////                'powerid': '71',
//               'children': {
//                   'notice': {
//                       'text': '正式党员',
//                       'url': '/partybuilding/partymember/list.jsp',
//
//                   },   
//                 'notice1': {
//                       'text': '预备党员',
//                       'url': '/partybuilding/partymember/list1.jsp',
//
//                   }, 
//                'notice2': {
//                       'text': '党员发展对象',
//                       'url': '/partybuilding/partymember/list2.jsp',
//
//                   },   
//               'notice3': {
//                       'text': '退党党员',
//                       'url': '/partybuilding/partymember/list3.jsp',
//
//                   },        
//               }
//           },              
//            'menutop3': {
//               'text': "支部建制",
////                'powerid': '71',
//               'children': {
//                   'notice': {
//                       'text': '支部建制',
//                       'url': '/partybuilding/party.html',
//
//                   },                                
//               }
//           },                
//           'menutop4': {
//               'text': "计划总结",
////                'powerid': '71',
//               'children': {
//                   'notice': {
//                       'text': '党委',
//                       'url': '/plan/list.jsp',
//
//                   },     
//                   'notice1': {
//                       'text': '支部',
//                       'url': '/plan/branchlist.jsp',
//
//                   },                    
//               }
//           },        
//           
//            'menutop5': {
//               'text': "党校培训",
////                'powerid': '71',
//               'children': {
//                   'notice': {
//                       'text': '发展对象培训',
//                       'url': '/partybuilding/party.html',
//
//                   },     
//                   'notice1': {
//                       'text': '预备党员培训',
//                       'url': '/partybuilding/party.html',
//
//                   },                    
//               }
//           },                         
//           
//           'menutop6': {
//               'text': "党日活动",
////                'powerid': '71',
//               'children': {
//                   'notice': {
//                       'text': '党日活动',
//                       'url': '/visualdata/party.html',
//
//                   },                          
//               }
//           },                            
//           
//            'menutop7': {
//               'text': "党建考核",
////                'powerid': '71',
//               'children': {
//                   'notice': {
//                       'text': '党建考核',
//                       'url': '/visualdata/party.html',
//
//                   },                          
//               }
//           },   
//         'menutop8': {
//               'text': "结对共建",
////                'powerid': '71',
//               'children': {
//                   'notice': {
//                       'text': '结对共建',
//                       'url': '/visualdata/party.html',
//
//                   },                          
//               }
//           },      
//           
//        'menutop9': {
//               'text': "党务工作提醒",
////                'powerid': '71',
//               'children': {
//                   'notice': {
//                       'text': '党务工作提醒',
//                       'url': '/visualdata/party.html',
//
//                   },                          
//               }
//           },         
           
           
        }
    },
    
       //  评议监督系统
    'top37': {
        'text': '评议监督系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/comment.html',

                    },                 
                    
                }
            },                          
        }
    },
    
    
      //  表决系统
    'top38': {
        'text': '表决系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/vote.html',

                    },                 
                    
                }
            },                          
        }
    },  
    
     //  政府债务监督系统
    'top39': {
        'text': '政府债务监督系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/debt.html',

                    },                 
                   'notice1': {
                        'text': '风险评估',
                        'url': '/visualdata/debt.html',

                    },  
                     'notice2': {
                        'text': '风险预警',
                        'url': '/visualdata/debt.html',

                    }, 
                }
            },                          
        }
    },   
    
   //  知情知政
    'top40': {
        'text': '知情知政',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/knowother.html',

                    },                 
                    
                }
            },                          
        }
    },     
    
   //  食品安全监督系统
    'top41': {
        'text': '食品安全监督系统',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "首页",
//                'powerid': '71',
                'children': {
                    'notice': {
                        'text': '数据统计',
                        'url': '/visualdata/food.html',

                    },                 
                    
                }
            },                          
        }
    },    
    
    
    
    //     重大决定
     'top42': {
        'text': '重大决定',
//        'powerid': '70',
        'children': {
            'menutop': {
                'text': "功能导航",
                'children': {
                }
            },
            'menutop1': {
                'text': "代表数据统计",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '人大代表学历统计',
                        'url': '/visualdata/bigdataDelegate.html',
                    },
                    'monitor1': {
                        'text': '人大代表数量统计',
                        'url': '/visualdata/quantity.html',
                    }
                    ,
                    'monitor2': {
                        'text': '人大代表性别统计',
                        'url': '/visualdata/gender.html',
                    }
                    ,
                    'monitor3': {
                        'text': '人大代表党派',
                        'url': '/visualdata/party.html',
                    }
                    ,
                    'monitor4': {
                        'text': '人大代表民族统计',
                        'url': '/visualdata/nationality.html',
                    }
                    ,
//                    'monitor5': {
//                        'text': '人大代表届次统计',
//                        'url': '/visualdata/session.html',
//                    }
//                    ,
//                    'monitor6': {
//                        'text': '代表团履职统计',
//                        'url': '/visualdata/deputy.html',
//                    }
//                    
                }
            },
            'menutop2': {
                'text': "建议议案统计",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '建议议案统计',
                        'url': '/visualdata/deputy.html',
                    }
//                    'monitor1': {
//                        'text': '履职活动统计',
//                        'url': '/visualdata/activity.html',
//                    }
                   
                    
                }
            },
            'menutop3': {
                'text': "履职数据统计",
                'children': {             
                    'monitor1': {
                        'text': '按出席人大会统计',
                        'url': '/visualdata/activity.html',
                    },
                    'monitor2': {
                        'text': '按参加其他会议统计',
                        'url': '/visualdata/activity2.html',
                    } ,
                    'monitor3': {
                        'text': '按学习培训统计',
                        'url': '/visualdata/activity3.html',
                    },
                    'monitor4': {
                        'text': '按提出建议议案统计',
                        'url': '/visualdata/activity4.html',
                    },
                    'monitor5': {
                        'text': '按开展专题调研统计',
                        'url': '/visualdata/activity5.html',
                    },
                    
                    'monitor6': {
                        'text': '按参加视察调研执法检查统计',
                        'url': '/visualdata/activity6.html',
                    },
                    'monitor7': {
                        'text': '按接待选民统计',
                        'url': '/visualdata/activity7.html',
                    },
                     'monitor8': {
                        'text': '按化解矛盾纠纷统计',
                        'url': '/visualdata/activity8.html',
                    },
                     'monitor9': {
                        'text': '按扶弱济贫统计',
                        'url': '/visualdata/activity9.html',
                    },
                     'monitor10': {
                        'text': '按办好事、办实事统计',
                        'url': '/visualdata/activity10.html',
                    },
                    'monitor11': {
                        'text': '按参加公益慈善事业统计',
                        'url': '/visualdfaata/activity11.html',
                    },
                    'monitor12': {
                        'text': '按向选民述职统计',
                        'url': '/visualdata/activity12.html',
                    },
                    'monitor13': {
                        'text': '按向其他统计',
                        'url': '/visualdata/activity13.html',
                    },
                    'monitor14': {
                        'text': '按向履职总数统计',
                        'url': '/visualdata/activity14.html',
                    },
                    'monitor15': {
                        'text': '按履职得分统计',
                        'url': '/visualdata/activity15.html',
                    },
                }
            },
            'menutop4': {
                'text': "人大监督数据统计",
//                'powerid': '71',
                'children': {
                    'monitor': {
                        'text': '听取和审议专项工作报告统计',
                        'url': '/visualdata/specialwork.html',
                    },
                    'monitor1': {
                        'text': '执法检查统计',
                        'url': '/visualdata/enforcement.html',
                    },
                    'monitor2': {
                        'text': '规范性文件备案统计',
                        'url': '/visualdata/regularfile.html',
                    },
                    'monitor3': {
                        'text': '专项询问统计',
                        'url': '/visualdata/specialinquery.html',
                    },
                    'monitor4': {
                        'text': '特定问题调查统计',
                        'url': '/visualdata/specialinvestigate.html',
                    },
                    'monitor5': {
                        'text': '撤职案的审议和决定统计',
                        'url': '/visualdata/dissmissal.html',
                    },
                    'monitor6': {
                        'text': '视察统计',
                        'url': '/visualdata/insepction.html',
                    },
                    'monitor7': {
                        'text': '调研统计',
                        'url': '/visualdata/investigation.html',
                    },
                }
            },

          
        }
    },
      
}